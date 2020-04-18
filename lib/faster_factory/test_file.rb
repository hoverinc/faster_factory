module FasterFactory
  class TestFile
    def initialize file_path
      @file_path = file_path
      clean_file_path!
    end

    def absolute_path
      [Dir.pwd, @file_path].join '/'
    end

    private

    def read_file
      ::File.read @file_path
    end

    def clean_file_path!
      @file_path = @file_path[1..-1] if @file_path.start_with? '/'
    end
  end
end
