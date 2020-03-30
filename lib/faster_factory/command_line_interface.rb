require 'optparse'
require 'faster_factory/cli/options'

module FasterFactory
  class CommandLineInterface
    class << self
      def start cli_args
        options = FasterFactory::CLI::Options.parse cli_args
        command = [] # FasterFactory::Commands.parse cli_args
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
