require 'optparse'

module FasterFactory
  class CLI
    class << self
      def start options
        options = FasterFactory::Options.parse options
        # commands = FasterFactory::Commands.parse(options)

        puts options.inspect
      end
    end
  end
end
