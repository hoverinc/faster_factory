require 'optparse'
require 'faster_factory/cli/options'
require 'faster_factory/cli/command'

module FasterFactory
  class CommandLineInterface
    class << self
      def start cli_args
        command = FasterFactory::CLI::Command.new cli_args.shift
        options = FasterFactory::CLI::Options.new cli_args
        files   = [] # FasterFactory::Files.parse cli_args

        puts "Options:"
        puts "  #{options.inspect}"
        puts
        puts "Command:"
        puts "  #{command.inspect}"
        puts
        puts "Files:"
        puts "  #{files.inspect}"
        puts
      end
    end
  end
end
