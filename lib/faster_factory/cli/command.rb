module FasterFactory
  module CLI
    class Command
      attr_accessor :name

      ALLOWED_COMMANDS = %w[help run]

      class << self
        def parse args
          FasterFactory::CLI::Command.new args
        end
      end

      def initialize args
        parse! args
        self
      end

      private

      def parse! args
        @name = args.first if ALLOWED_COMMANDS.include?(args.first)
      end
    end
  end
end
