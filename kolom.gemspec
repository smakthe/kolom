# frozen_string_literal: true

require_relative "lib/kolom/version"

Gem::Specification.new do |spec|
  spec.name = "kolom"
  spec.version = Kolom::VERSION
  spec.authors = ["smakthe"]
  spec.email = ["scmakra99@gmail.com"]

  spec.summary = "Kolom - A Bengali scripting language"
  spec.description = "A toy scripting language with Bengali keywords that compiles to Ruby"
  spec.homepage = "https://github.com/smakthe/kolom"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/smakthe/kolom"
  spec.metadata["changelog_uri"] = "https://github.com/smakthe/kolom/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    EXCLUDED_DIRECTORIES = %w[bin/ test/ spec/ features/ .git appveyor Gemfile].freeze
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == File.basename(__FILE__)) || f.start_with?(*EXCLUDED_DIRECTORIES)
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "parser", "~> 3.0"
  spec.add_dependency "unparser", "~> 0.6"
  
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
