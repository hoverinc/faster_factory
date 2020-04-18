require 'faster_factory/file_path'

module FasterFactory
  module CLI
    class FileSet
      attr_accessor :paths

      def initialize files
        @files_arg = files
        setup!
      end

      def all
        @paths.map { |path| FasterFactory::TestFile.new path }
      end

      private

      def setup!
        fallback_to_default_directories!
        expand_paths!
        expand_directories!

        self
      end

      def fallback_to_default_directories!
        @files_arg = %w[spec test] if @files_arg.empty?
      end

      def expand_paths!
        @paths = @files_arg.map { |file_arg| file_path_for(file_arg) }.compact
      end

      def file_path_for file_arg
        FasterFactory::FilePath.new(file_arg).path
      end

      def expand_directories!
        expanded_directories = []

        @paths.each do |path|
          expanded_directories << if File.file?(path)
                                    path
                                  else
                                    Dir.glob("#{path}/**/*.rb")
                                  end
        end

        @paths = expanded_directories.flatten.compact
      end
    end
  end
end
