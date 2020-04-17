require 'optparse'
require 'faster_factory/cli/options'
require 'faster_factory/cli/files'

module FasterFactory
  class CommandLineInterface
    def initialize cli_args
      # Special case for `faster_factory help`:
      # Avoid running on spec/ or test/ when asked for help text
      cli_args = ['-h'] if cli_args.first == 'help'

      # Parse CLI options
      @options = FasterFactory::CLI::Options.new cli_args

      # Build list of files to work on
      @files = FasterFactory::CLI::Files.new cli_args
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

          if line.create_present?
            puts "'.create' found on line: #{line_number}"
            line.replace_create_with_build!
            puts "Replaced '.create' with '.build'"

            content = lines.map(&:content).join

            tcr! path: path, content: content, line_number: line_number, from: 'create', to: 'build'
          end

          if line.build_present?
            puts "'.build' found on line: #{line_number}"
            line.replace_build_with_build_stubbed!
            puts "Replaced '.build' with '.build_stubbed'"

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
      puts "*"*80
      puts "Running RSpec"
      rspec_command = "bundle exec rspec #{path}:#{line_number}"
      rspec_output = `#{rspec_command}`
      puts "*"*80

      if rspec_output =~ /Failures:/
        puts "SPECS FAILED"
        puts "Resetting changes back to working state"
        `git reset --hard`
        puts "*"*80
      else
        puts "Success!"
        puts "On line: #{line_number}"
        puts "Of file: #{path}"
        puts "Found and replaced: '.#{from}' with '.#{to}'"
        puts

        puts "Specs passed with using *line* strategy:"
        puts "  bundle exec rspec #{relative_file_path}:#{line_number}"
        puts

        message = "[TCR] Replace .#{from} with .#{to} in #{relative_file_path}:#{line_number}"
        puts "Committing change with message:"
        puts "  #{message}"
        puts
        `git commit -am "#{message}"`

        # puts "TODO: print output"
        # puts "TODO: git commit unless no_git?"
      end
    end
  end
end
