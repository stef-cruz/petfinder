require_relative 'lib/petfinder/version'

Gem::Specification.new do |spec|
  spec.name          = "petfinder"
  spec.version       = Petfinder::VERSION
  spec.authors       = ["stef-cruz"]
  spec.email         = ["scruz@kitmanlabs.com"]

  spec.summary       = %q{Gem wrapper to the Petfinder API.}
  spec.description   = %q{Gem wrapper to the Petfinder API.}
  spec.homepage      = "https://github.com/stef-cruz/petfinder"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/stef-cruz/petfinder"
  spec.metadata["changelog_uri"] = "https://github.com/stef-cruz/petfinder/blob/master/README.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency('byebug')
  spec.add_development_dependency('webmock', '~> 3.0')
  spec.add_development_dependency('simplecov', '~> 0.15')
  spec.add_development_dependency('rubocop', '~> 1.31.2')
  spec.add_dependency "faraday"
end
