lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "faster_factory/version"

Gem::Specification.new do |spec|
  spec.name          = "faster_factory"
  spec.version       = FasterFactory::VERSION
  spec.authors       = ["Shane Becker"]
  spec.email         = ["veganstraightedge@gmail.com"]

  spec.summary       = "Make FactoryBot factories go faster"
  spec.description   = <<~DESCRIPTION
    Finds and replaces FactoryBot factories in tests with faster methods.
    Prefers .build_stubbed over .build over .create.
    Changes one at a time, run the localized test for that change.
    If it passes, commits it. If it fails reverts it.
  DESCRIPTION

  spec.homepage      = "https://github.com/hoverinc/faster_factory"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hoverinc/faster_factory"
  spec.metadata["changelog_uri"] = "https://github.com/hoverinc/faster_factory/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
