require 'optparse'
require 'faster_factory/cli/command'
require 'faster_factory/cli/files'
require 'faster_factory/cli/options'

module FasterFactory
  class CommandLineInterface
    class << self
      def start cli_args
        command = FasterFactory::CLI::Command.new cli_args.shift
        files   = FasterFactory::CLI::Files.new cli_args.first
        options = FasterFactory::CLI::Options.new cli_args

        puts "Command:"
        puts "  #{command.inspect}"
        puts
        puts "Files:"
        puts "  #{files.inspect}"
        puts
        puts "Options:"
        puts "  #{options.inspect}"
        puts
      end
    end
  end
end
