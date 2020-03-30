require 'optparse'

module FasterFactory
  class CLI
    class << self
      def start cli_args
        options = FasterFactory::Options.parse cli_args
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
