module FasterFactory
  class Commit
    def initialize from:, to:, path:, line_number:, template: nil
      @from        = from
      @to          = to
      @path        = path
      @line_number = line_number
      @template    = template
    end

    def content
      return default_content if @template.nil?

      @template
    end

    private

    def default_content
      "[TCR] Replace '#{@from}' with '#{@to}' in #{@path}:#{@line_number}"
    end
  end
end
