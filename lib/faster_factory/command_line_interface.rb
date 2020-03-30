require 'optparse'
require 'faster_factory/cli/options'
require 'faster_factory/cli/files'

module FasterFactory
  class CommandLineInterface
    class << self
      def start cli_args
        options = FasterFactory::CLI::Options.new cli_args
        files   = FasterFactory::CLI::Files.new cli_args

        puts "Files:"
        puts files.paths
        puts
      end
    end
  end
end
