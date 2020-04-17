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

    def create_present?
      match = @content =~ %r{\.create}
      !match.nil?
    end

    def replace_create_with_build!
      @content = @original_content.sub('.create', '.build')
    end
  end
end
