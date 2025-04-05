require "json"
require "stringio"

# Kolom is a Ruby interpreter that allows you to write Ruby-like code using Bengali keywords.
module Kolom
  VERSION = ENV["KOLUM_VERSION"] || "0.1.0"

  # Bengali translations of Ruby keywords
  keymap_filepath = File.join(File.dirname(__FILE__), "kolom/keymap.json")
  keymap_file = File.open(keymap_filepath)
  KEYWORDS = JSON.load(keymap_file).freeze

  # Inverse mapping for translating back
  RUBY_KEYWORDS = KEYWORDS.invert

  # Load  all files in the kolom directory
  Dir.glob(File.join(__dir__, "kolom", "*.rb")).each do |file_path|
    # Construct the relative path like "kolom/filename" and require it

    require_relative File.join("kolom", File.basename(file_path, ".rb"))
  rescue LoadError => e
    warn "Failed to load #{File.join("kolom", File.basename(file_path, ".rb"))}: #{e.message}"
  end

  # The Interpreter class is responsible for executing the translated Ruby code.
  class Interpreter
    attr_reader :env, :output

    def initialize
      @env = {}
      @output = StringIO.new
      # setup_global_environment
    end

    def evaluate(code)
      ruby_code = translate_to_ruby(code)

      # Create an instance of DSLContext
      dsl_context = Kolom::MetaProgramming::DSLContext.new

      # Evaluate the translated code in the DSL context
      result = dsl_context.instance_eval(ruby_code)

      # Return the result and any output
      [result, @output.string]
    end

    def translate_to_ruby(code)
      # This is a simple token-based translation
      # In a real implementation, a proper parser might be used

      # Replace Bengali keywords with Ruby keywords
      KEYWORDS.each do |bengali, ruby|
        # We need to be careful with word boundaries
        code = code.gsub(/\b#{bengali}\b/, ruby)
      end

      code
    end
  end
end
