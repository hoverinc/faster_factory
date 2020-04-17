module FasterFactory
  class Line
    def initialize content
      @content = content
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
