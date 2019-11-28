
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "libgen_api/version"

Gem::Specification.new do |spec|
  spec.name          = "libgen_api"
  spec.version       = LibgenApi::VERSION
  spec.authors       = ["Sag0Sag0"]
  spec.email         = ["Sag0Sag0@outlook.com"]

  spec.summary       = "An API that can be used to search Library Genesis"
  spec.description   = "An API that can be used to search Library Genesis. In the early stages."
  spec.homepage      = "https://github.com/Sag0Sag0/libgen_api"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.3"
end
