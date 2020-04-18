module FasterFactory
  class TestFile
    def initialize file_path
      @file_path    = file_path
      @file_handler = read_file
    end

    def path
      @file_handler
    end

    private

    def read_file
      ::File.read @file_path
    end
  end
end
