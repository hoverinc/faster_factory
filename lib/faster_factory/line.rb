module FasterFactory
  class Line
    def initialize content
      @content = content
    end

    def create_present?
      match = @content =~ %r{\.create}
      !match.nil?
    end
  end
end
