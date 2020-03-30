module FasterFactory
  class FilePath
    attr_accessor :path

    def initialize path
      @path = path

      validate_path_not_option!
      return self if @path.nil?

      expand_path!
      validate_file_exists!
      self
    end

    private

    def validate_path_not_option!
      @path = nil if @path.start_with? '-'
    end

    def expand_path!
      @path = File.expand_path @path, FileUtils.pwd
    end

    def validate_file_exists!
      @path = nil unless File.exist? @path
    end
  end
end
