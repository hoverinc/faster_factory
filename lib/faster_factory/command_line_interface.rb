require 'optparse'
require 'faster_factory/cli/options'
require 'faster_factory/cli/file_set'

module FasterFactory
  class CommandLineInterface
    class << self
      def for cli_args
        FasterFactory::CommandLineInterface.new(cli_args).start
      end
    end

    def initialize cli_args
      @cli_args = cli_args

      enable_help_flag!

      # Parse CLI options
      @options = FasterFactory::CLI::Options.new @cli_args

      # Build list of files to work on
      @files = FasterFactory::CLI::FileSet.new @cli_args
      binding.irb
    end

    def start
      # TEMP sketch
      puts '==> Reading files…'
      @files.paths.each do |path|
        relative_file_path = path.sub "#{Dir.pwd}/", ''
        puts "==> Reading: #{relative_file_path}"

        lines = []

        File.readlines(path).each do |file_line|
          lines << FasterFactory::Line.new(file_line)
        end

        lines.each_with_index do |line, index|
          line_number = index + 1

          # TEMP: un-DRY duplication

          if line.create_present?
            puts "==>   Found '.create' on line: #{line_number}"
            puts "==>   Replacing '.create' with '.build_stubbed'…"
            line.replace_create_with_build_stubbed!

            content = lines.map(&:content).join

            tcr! path: path, content: content, line_number: line_number, from: 'create', to: 'build_stubbed'
          end

          if line.create_present?
            puts "==>   Found '.create' on line: #{line_number}"
            puts "==>   Replacing '.create' with '.build'…"
            line.replace_create_with_build!

            content = lines.map(&:content).join

            tcr! path: path, content: content, line_number: line_number, from: 'create', to: 'build'
          end

          if line.build_present?
            puts "==>   Found '.build' on line: #{line_number}"
            puts "==>   Replacing '.build' with '.build_stubbed'…"
            line.replace_build_with_build_stubbed!

            content = lines.map(&:content).join

            tcr! path: path, content: content, line_number: line_number, from: 'build', to: 'build_stubbed'
          end
        end
      end
    end

    def tcr! path:, content:, line_number:, from:, to:
      # TEMP
      relative_file_path = path.sub "#{Dir.pwd}/", ''

      File.write(path, content)
      puts
      puts "==> Running Tests…"
      rspec_command = "bundle exec rspec #{path}:#{line_number}"
      rspec_output = `#{rspec_command}`

      if rspec_output =~ /Failures:/
        puts "==>   Tests FAILED"
        puts "==>   Resetting changes back to previous state using:"
        puts "==>     git reset --hard"
        `git reset --hard`
        puts
      else
        puts "==>   Success! Tests PASSED"
        puts

        puts "==> Tests passed with using *line* strategy:"
        puts "==>   bundle exec rspec #{relative_file_path}:#{line_number}"
        puts

        message = "[TCR] Replace .#{from} with .#{to} in #{relative_file_path}:#{line_number}"
        puts "==> Committing change with message:"
        puts "==>   #{message}"
        puts
        `git commit -am "#{message}"`
        puts

        # puts "TODO: print output"
        # puts "TODO: git commit unless no_git?"
      end
    end

    private

    def enable_help_flag!
      # Special case for `faster_factory help`:
      # Avoid running on spec/ or test/ when asked for help text
      @cli_args = ['-h'] if @cli_args.first == 'help'
    end
  end
end
