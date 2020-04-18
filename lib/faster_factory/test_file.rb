module FasterFactory
  class TestFile
    attr_reader :path

    def initialize path
      @path = path
      clean_path!
    end

    def absolute_path
      [Dir.pwd, @path].join '/'
    end

    def content
      ::File.read(absolute_path)
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

    def clean_path!
      @path.sub! %r{\A/+}, ''
    end
  end
end
