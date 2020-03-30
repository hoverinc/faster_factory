require 'optparse'

module FasterFactory
  class CLI
    class << self
      def start cli_args
        options = FasterFactory::Options.parse cli_args
        # commands = FasterFactory::Commands.parse(options)

        puts options.inspect
      end
    end
  end
end
