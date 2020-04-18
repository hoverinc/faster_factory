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

    private

    def read_file
      ::File.read @path
    end

    def clean_path!
      @path.sub! %r{\A/+}, ''
    end
  end
end
