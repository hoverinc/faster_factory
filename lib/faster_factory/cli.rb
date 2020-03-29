require 'optparse'

module FasterFactory
  class CLI
    def self.start options
      args = FasterFactory::Options.new

      option_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: faster_factory [command] [path/to/folder/or/file] [options]'

        opts.on('--dry-run', TrueClass, 'Prints report instead of keeping any changes') do |dr|
          args.dry_run = dr
        end

        opts.on('--no-git', TrueClass, 'Runs without committing successful changes') do |ng|
          args.no_git = ng
        end

        opts.on('-h', '--help', 'Displays this help text') do
          puts opts
          exit
        end

        opts.on('-mMESSAGE', '--message=MESSAGE', String, 'Sets a custom message for each git commit', 'It can include {{file}} for file name') do |m|
          args.message = m
        end

        opts.on('-sSTRATEGY', '--strategy=STRATEGY', Array, 'Sets the test strategy: line|file|all', 'You can combine strategies for extra checks:', 'line,file|line,all|file,all|line,file,all') do |s|
          args.strategy = s
        end
      end

      option_parser.parse! options
      puts args.dry_run.inspect
      puts args.dry_run.class
      puts args.no_git.inspect
      puts args.no_git.class
      puts args.message.inspect
      puts args.message.class
      puts args.strategy.inspect
      puts args.strategy.class
    end
  end
end
