module FasterFactory
  class Line
    attr_reader :original_content

    def initialize content
      @content          = content
      @original_content = content
    end

    def create_present?
      match = @content =~ %r{\.create}
      !match.nil?
    end

    def build_present?
      match = @content =~ %r{\.build}
      !match.nil?
    end
  end
end
