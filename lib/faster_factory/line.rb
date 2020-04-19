module FasterFactory
  class Line
    attr_reader :original_content, :content

    def initialize content
      @content          = content
      @original_content = content
    end

    def build_present?
      match = @content =~ %r{\.build}
      !match.nil?
    end

    def build_stubbed_present?
      match = @content =~ %r{\.build_stubbed}
      !match.nil?
    end

    def create_present?
      match = @content =~ %r{\.create}
      !match.nil?
    end

    def replace_create_with_build_stubbed!
      mapping = {
        '.create' => '.build_stubbed'
      }

      mapping.each { |from, to| @content.sub! from, to }
    end

    def replace_create_with_build!
      mapping = {
        '.create' => '.build'
      }

      mapping.each { |from, to| @content.sub! from, to }
    end

    def replace_build_with_build_stubbed!
      mapping = {
        '.build ' => '.build_stubbed ',
        '.build(' => '.build_stubbed('
      }

      mapping.each { |from, to| @content.sub! from, to }
    end
  end
end
