module FasterFactory
  class CommitMessage
    def initialize path:, line_number:, template: nil
      @path        = path
      @line_number = line_number
      @template    = template
    end
  end
end
