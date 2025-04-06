# frozen_string_literal: true

# Load environment variables from .env file

require "dotenv"
Dotenv.load

Gem::Specification.new do |spec|
  spec.name = "kolom"
  spec.version = ENV["KOLUM_VERSION"]
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
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    excluded_directories = %w[bin/ test/ spec/ features/ .git appveyor Gemfile].freeze
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == File.basename(__FILE__)) || f.start_with?(*excluded_directories)
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
