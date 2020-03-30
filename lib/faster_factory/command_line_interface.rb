require 'optparse'
require 'faster_factory/cli/command'
require 'faster_factory/cli/files'
require 'faster_factory/cli/options'

module FasterFactory
  class CommandLineInterface
    class << self
      def start cli_args
        command = FasterFactory::CLI::Command.new cli_args.shift
        files   = FasterFactory::CLI::Files.new cli_args
        options = FasterFactory::CLI::Options.new cli_args

        puts "Command:"
        puts "  #{command.name}"
        puts
        puts "Files:"
        puts "  #{files.paths}"
        puts
        puts "Options:"
        puts "  --no-git"
        puts "  #{options.no_git.inspect}"
        puts "  #no_git? #=> #{options.no_git?}"
        puts
        puts "  --dry-run"
        puts "  #{options.dry_run.inspect}"
        puts "  #dry_run? #=> #{options.dry_run?}"
        puts
        puts "  --message"
        puts "  #{options.message}"
        puts
        puts "  --strategy"
        puts "  #{options.strategies}"
        puts
      end
    end
  end
end
