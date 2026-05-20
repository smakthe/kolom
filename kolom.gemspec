# frozen_string_literal: true

require_relative "lib/kolom/version"

Gem::Specification.new do |spec|
  spec.name = "kolom"
  spec.version  = Kolom::VERSION
  spec.authors = ["smakthe"]
  spec.email = ["scmakra99@gmail.com"]

  spec.summary = "কলম - A Bengali scripting language"
  spec.description = "A toy scripting language with Bengali keywords that compiles to Ruby"
  spec.homepage = "https://rubygems.org/gems/kolom"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/smakthe/kolom"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
  "lib/**/*.rb",
  "lib/**/*.json",
  "LICENSE.txt",
  "README.md"
]
  spec.bindir = "bin"
  spec.executables = ["kolom"]
  spec.require_paths = ["lib"]
end
