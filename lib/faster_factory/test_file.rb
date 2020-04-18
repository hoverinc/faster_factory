module FasterFactory
  class TestFile
    def initialize path
      @path = strip_absolute_path_prefix path
    end

    def absolute_path
      [Dir.pwd, @path].join '/'
    end

    def path
      strip_leading_slashes @path
    end

    def lines
      ::File.readlines(absolute_path).map do |line_content|
        FasterFactory::Line.new line_content
      end
    end

    private

    def read_file
      ::File.read @path
    end

    def strip_leading_slashes path
      path = path.sub %r{\A/+}, ''
    end

    def strip_absolute_path_prefix path
      absolute = "/#{path}".gsub Dir.pwd, ''
      strip_leading_slashes absolute
    end
  end
end
