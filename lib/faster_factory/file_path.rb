module FasterFactory
  class FilePath
    attr_accessor :path

    def initialize path
      @path = path

      validate_path_not_option
      expand_path unless @path.nil?
      self
    end

    private

    def validate_path_not_option
       @path = nil if @path.start_with?('-')
    end

    def expand_path
      @path = File.expand_path(@path, FileUtils.pwd)
    end
  end
end
