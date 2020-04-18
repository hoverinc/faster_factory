module FasterFactory
  class Changeset
    def initialize from:, to:, path:, line_number:, template: nil
      @from        = from
      @to          = to
      @path        = path
      @line_number = line_number
      @template    = template
    end

    def message
      return default_message if @template.nil?

      @template
    end

    def commit
      puts "==> Committing change with message:"
      puts "==>   #{message}"
      puts
      `git commit -am "#{message}"`
      puts
    end

    private

    def default_message
      "[TCR] Replace '#{@from}' with '#{@to}' in #{@path}:#{@line_number}"
    end
  end
end
