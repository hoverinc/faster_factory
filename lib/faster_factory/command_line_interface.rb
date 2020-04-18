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

      # Build set of files to work on
      @file_set = FasterFactory::CLI::FileSet.new @cli_args
    end

    def start
      # TEMP sketch
      puts '==> Reading files…'
      @file_set.all.each do |file|
        puts "==> Reading: #{file.path}"

        lines = file.lines

        lines.each_with_index do |line, index|
          line_number = index + 1

          # TEMP: un-DRY duplication
          if line.create_present?
            puts "==>   Found '.create' on line: #{line_number}"
            puts "==>   Replacing '.create' with '.build_stubbed'…"

            line.replace_create_with_build_stubbed!
            File.write file.path, lines.map(&:content).join

            tcr! path: file.path, line_number: line_number, from: 'create', to: 'build_stubbed'
          end

          if line.create_present?
            puts "==>   Found '.create' on line: #{line_number}"
            puts "==>   Replacing '.create' with '.build'…"

            line.replace_create_with_build!
            File.write file.path, lines.map(&:content).join

            tcr! path: file.path, line_number: line_number, from: 'create', to: 'build'
          end

          if line.build_present?
            puts "==>   Found '.build' on line: #{line_number}"
            puts "==>   Replacing '.build' with '.build_stubbed'…"

            line.replace_build_with_build_stubbed!
            File.write file.path, lines.map(&:content).join

            tcr! path: file.path, line_number: line_number, from: 'build', to: 'build_stubbed'
          end
        end
      end
    end

    def tcr! path:, line_number:, from:, to:
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
        puts "==>   bundle exec rspec #{path}:#{line_number}"
        puts

        message = "[TCR] Replace .#{from} with .#{to} in #{path}:#{line_number}"
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
