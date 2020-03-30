module FasterFactory
  module CLI
    class Command
      attr_accessor :name

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

      def allowed_commands
        %w[help run].map(&:freeze).freeze
      end

      def parse! args
        @name = args.first if allowed_commands.include?(args.first)
      end
    end
  end
end
