require 'faster_factory/file_path'

module FasterFactory
  module CLI
    class Files
      attr_accessor :paths

      def initialize files
        @files_arg = files

        fallback_to_default_directories!
        expand_paths!

        self
      end

      private

      def fallback_to_default_directories!
        @files_arg = %w[spec test] if @files_arg.empty?
      end

      def expand_paths!
        @paths = @files_arg.map { |file_arg| file_path_for(file_arg) }.compact
      end

      def file_path_for file_arg
        FasterFactory::FilePath.new(file_arg).path
      end
    end
  end
end
