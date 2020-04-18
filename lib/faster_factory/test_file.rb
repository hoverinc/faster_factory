module FasterFactory
  class TestFile
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
      @path = @path[1..-1] if @path.start_with? '/'
    end
  end
end
