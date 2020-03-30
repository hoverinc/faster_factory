module FasterFactory
  class Options
    attr_accessor :dry_run, :no_git, :message, :strategy

    class << self
      def parse options
        FasterFactory::Options.new options
      end
    end

    def initialize options
      option_parser.parse! options
      self
    end

    private

    def option_parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: faster_factory [command] [path/to/folder/or/file] [options]'

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
          @strategy = s
        end
      end
    end
  end
end
