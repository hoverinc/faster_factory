module FasterFactory
  module CLI
    class Command
      attr_accessor :name

      def initialize arg
        parse! arg
        self
      end

      private

      def allowed_commands
        %w[help run].map(&:freeze).freeze
      end

      def parse! arg
        @name = arg if allowed_commands.include? arg
      end
    end
  end
end
