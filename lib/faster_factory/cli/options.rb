module FasterFactory
  module CLI
    class Options
      attr_accessor :dry_run, :no_git, :message, :strategies

      def initialize options
        @options = options
        setup!
      end

      def dry_run?
        !!@dry_run
      end

      def no_git?
        !!@no_git
      end

      private

      def setup!
        option_parser.parse! @options
        self
      end

      def option_parser
        OptionParser.new do |opts|
          opts.banner = <<~BANNER

            Faster Factory finds FactoryBot factories and replaces them with faster methods.
              Prefers .build_stubbed over .build over .create.
              Defaults to using spec/ or test/ directories.

            Usage: faster_factory [options] [path/to/folder/or/file]

            Options:
          BANNER

          opts.on('--dry-run', TrueClass, 'Prints report instead of keeping any changes') do |dr|
            @dry_run = dr
          end

          opts.on('--no-git', TrueClass, 'Runs without committing successful changes') do |ng|
            @no_git = ng
          end

          opts.on('-h', '--help', 'Displays this help text') do
            puts opts
            exit
          end

          opts.on('-mMESSAGE', '--message=MESSAGE', String, 'Sets a custom message for each git commit', 'It can include {{file}} for file name') do |m|
            @message = m
          end

          opts.on('-sSTRATEGY', '--strategy=STRATEGY', Array, 'Sets the test strategy: line|file|all', 'You can combine strategies for extra checks:', 'line,file|line,all|file,all|line,file,all') do |s|
            @strategies = s
          end
        end
      end
    end
  end
end
