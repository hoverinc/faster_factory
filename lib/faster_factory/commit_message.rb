module FasterFactory
  class CommitMessage
    def initialize path:, line_number:, content: nil
      @path        = path
      @line_number = line_number
      @content     = content
    end
  end
end
