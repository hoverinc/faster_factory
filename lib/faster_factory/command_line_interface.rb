require 'optparse'
require 'faster_factory/cli/options'
require 'faster_factory/cli/files'

module FasterFactory
  class CommandLineInterface
    class << self
      def start cli_args
        options = FasterFactory::CLI::Options.new cli_args
        files   = FasterFactory::CLI::Files.new cli_args

        puts "Files:"
        puts files.paths
        puts
        puts "Options:"
        puts "--no-git"
        puts "#{options.no_git.inspect}"
        puts "#no_git? #=> #{options.no_git?}"
        puts
        puts "--dry-run"
        puts "#{options.dry_run.inspect}"
        puts "#dry_run? #=> #{options.dry_run?}"
        puts
        puts "--message"
        puts "#{options.message}"
        puts
        puts "--strategy"
        puts "#{options.strategies}"
        puts
      end
    end
  end
end
