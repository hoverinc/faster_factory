require 'optparse'

Options = Struct.new(:name)

module FasterFactory
  class CLI
    def self.start options
      args = Options.new('world')

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: faster_factory [command] [path/to/folder/or/file] [options]'

        opts.on('--dry-run', 'Prints report instead of keeping any changes') do
          puts opts
          exit
        end

        opts.on('--no-git', 'Runs without committing successful changes') do
          puts opts
          exit
        end

        opts.on('help', '-h', '--help', 'Displays this help') do
          puts opts
          exit
        end

        opts.on('-mMESSAGE', '--message=MESSAGE', 'Custom commit message, can use {{file}} for file name') do |m|
          args.message = m
        end

        opts.on('-sSTRATEGY', '--strategy=STRATEGY', 'Test strategy: line file all line,file file,all line,file,all') do |s|
          args.strategy = s
        end
      end

      opt_parser.parse!(options)
      return args
    end
  end
end
