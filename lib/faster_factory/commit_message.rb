module FasterFactory
  class CommitMessage
    def initialize from:, to:, path:, line_number:, template: nil
      @from        = from
      @to          = to
      @path        = path
      @line_number = line_number
      @template    = template
    end

    def content
      "[TCR] Replace .build with .build_stubbed in #{@path}:#{@line_number}"
    end
  end
end
