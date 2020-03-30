require 'faster_factory/file_path'

module FasterFactory
  module CLI
    class Files
      attr_accessor :paths

      def initialize files
        @files_arg = files
        parse! files
        self
      end

      private

      def parse! files
        @paths = provided_paths_or_default_paths.flatten
      end

      def provided_paths_or_default_paths
        @files_arg.first.start_with?('-') ? test_or_spec : paths_from_args
      end

      def test_or_spec
        test_dirs = []
        test_dirs << 'spec' if Dir.exist? './spec'
        test_dirs << 'test' if Dir.exist? './test'
        test_dirs
      end

      def paths_from_args
        file_paths = []

        @files_arg.each do |file_arg|
          break if file_arg.start_with?('-')

          file_paths << FasterFactory::FilePath.new(file_arg).path
        end

        file_paths.compact
      end
    end
  end
end
