module FasterFactory
  module CLI
    class Command
      attr_accessor :name

      def initialize command
        parse! command
        self
      end

      private

      def allowed_commands
        %w[help run].map(&:freeze).freeze
      end

      def parse! command
        @name = command if allowed_commands.include? command
      end
    end
  end
end
