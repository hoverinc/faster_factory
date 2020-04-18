module FasterFactory
  class CommitMessage
    def initialize path:, line_number:
      @path = path
      @line_number = line_number
    end
  end
end
