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
        @paths = Array(provided_or_default).flatten
      end

      def provided_or_default
        @files_arg.first.start_with?('-') ? test_or_spec : paths_from_args
      end

      def paths_from_args
        files_paths = []

        @files_arg.each do |arg|
          break if arg.start_with?('-')
          files_paths << arg
        end

        files_paths
      end

      def test_or_spec
        test_dirs = []
        test_dirs << 'spec' if Dir.exist? './spec'
        test_dirs << 'test' if Dir.exist? './test'
        test_dirs
      end
    end
  end
end
