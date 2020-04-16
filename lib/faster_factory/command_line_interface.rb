require 'optparse'
require 'faster_factory/cli/options'
require 'faster_factory/cli/files'

module FasterFactory
  class CommandLineInterface
    def initialize cli_args
      # Special case for `faster_factory help`:
      # Avoid running on spec/ or test/ when asked for help text
      @cli_args = ['-h'] if @cli_args.first == 'help'

      # Parse CLI options
      @options = FasterFactory::CLI::Options.new @cli_args

      # Build list of files to work on
      @files = FasterFactory::CLI::Files.new @cli_args
    end

    def start
      # TEMP sketch
      puts '==> Reading files…'
      @files.paths.each do |path|
        relative_file_path = path.sub "#{Dir.pwd}/", ''
        puts "==> Reading: #{relative_file_path}"

        lines = []

        File.readlines(path).each do |line|
          create_present = line =~ /FactoryBot.create/
          build_present  = line =~ /FactoryBot.build/

          lines << {
            original_content: line,
            create_present: create_present,
            build_present: build_present,
            new_content: nil
          }
        end

        lines.each_with_index do |line, index|
          unless line[:build_present].nil?
            puts "'FactoryBot.create' found on line: #{index + 1}"
            line[:new_content] = line[:original_content].sub('FactoryBot.create', 'FactoryBot.build')
            puts "Replaced 'FactoryBot.build' with 'FactoryBot.create'"

            content = lines.map { |l| l[:new_content] || l[:original_content] }.join

            File.write(path, content)
            puts "*"*80
            puts "Running RSpec"
            rspec_command = "bundle exec rspec #{path}:#{index + 1}"
            rspec_output = `#{rspec_command}`
            puts "*"*80

            if rspec_output =~ /Failures:/
              puts "SPECS FAILED"
              `git reset --hard`
            else
              puts "Success!"
              puts "On line: #{index + 1}"
              puts "Of file: #{path}"
              puts "Found and replaced: 'FactoryBot.create' with 'FactoryBot.build'"
              puts

              puts "Specs passed with using *line* strategy:"
              puts "  bundle exec rspec #{relative_file_path}:#{index + 1}"
              puts

              message = "[TCR] Replace FactoryBot.create with FactoryBot.build in #{relative_file_path}"
              puts "Committing change with message:"
              puts "  #{message}"
              puts
              `git commit -am "#{message}"`

              # puts "TODO: print output"
              # puts "TODO: git commit unless no_git?"
            end
          end

          unless line[:build_present].nil?
          end
        end
      end
    end
  end
end
