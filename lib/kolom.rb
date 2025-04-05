require "json"
require "stringio"
require "parser"
require "unparser"

# Kolom is a Ruby interpreter that allows you to write Ruby-like code using Bengali keywords.
module Kolom
  VERSION = ENV["KOLUM_VERSION"] || "0.1.0"

  # Bengali translations of Ruby keywords
  keymap_filepath = File.join(File.dirname(__FILE__), "kolom/keymap.json")
  keymap_file = File.open(keymap_filepath)
  KEYWORDS = JSON.load(keymap_file).freeze

  # Inverse mapping for translating back
  RUBY_KEYWORDS = KEYWORDS.invert

  # The Interpreter class is responsible for executing the translated Ruby code.
  class Interpreter
    attr_reader :env, :output

    def initialize
      @env = {}
      @output = StringIO.new
      # setup_global_environment
    end

    def setup_global_environment
      # Add standard library functions and objects to the environment
      @env['লেখো'] = lambda do |*args|
        @output.puts args.join(' ')
      end

      @env['ইনপুট'] = lambda do |prompt = nil|
        @output.puts prompt if prompt
        gets.chomp
      end

      # Add numerical operations
      @env['যোগ_করুন'] = lambda { |a, b| a + b }
      @env['বিয়োগ_করুন'] = lambda { |a, b| a - b }
      @env['গুণ_করুন'] = lambda { |a, b| a * b }
      @env['ভাগ_করুন'] = lambda { |a, b| a / b }
    end

    def evaluate(code)
      ruby_code = translate_to_ruby(code)

      # Create a sandbox module to evaluate the code
      sandbox = Module.new

      # Use method_missing to handle Bengali methods
      sandbox.module_eval do
        def self.method_missing(method_name, *args, &block)
          bengali_method = Kolom::RUBY_KEYWORDS[method_name.to_s]
          if bengali_method
            send(bengali_method.to_sym, *args, &block)
          else
            super
          end
        end
      end

      # Evaluate the translated Ruby code
      result = sandbox.module_eval(ruby_code)

      # Return the result and any output
      [result, @output.string]
    end

    def translate_to_ruby(code)
      # This is a simple token-based translation
      # In a real implementation, you'd use a proper parser

      # Replace Bengali keywords with Ruby keywords
      KEYWORDS.each do |bengali, ruby|
        # We need to be careful with word boundaries
        code = code.gsub(/\b#{bengali}\b/, ruby)
      end

      code
    end
  end

  class Parser
    def self.parse(code)
      # This is a placeholder for a real parser implementation
      # In a complete implementation, you would:
      # 1. Tokenize the input
      # 2. Build an abstract syntax tree
      # 3. Transform the AST into executable Ruby code or directly execute it

      # For now, we'll just use the simple translation approach
      interpreter = Interpreter.new
      interpreter.translate_to_ruby(code)
    end
  end

  # Dynamic method handling for core classes
  module CoreExtensions
    # Define extensions for String class
    module StringMethods
      def method_missing(method_name, *args, &block)
        bengali_method = Kolom::KEYWORDS.key(method_name.to_s)
        if bengali_method
          send(Kolom::KEYWORDS[bengali_method].to_sym, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        Kolom::KEYWORDS.key(method_name.to_s) || super
      end
    end

    # Define extensions for Array class
    module ArrayMethods
      def method_missing(method_name, *args, &block)
        bengali_method = Kolom::KEYWORDS.key(method_name.to_s)
        if bengali_method
          send(Kolom::KEYWORDS[bengali_method].to_sym, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        Kolom::KEYWORDS.key(method_name.to_s) || super
      end
    end

    # Define extensions for Hash class
    module HashMethods
      def method_missing(method_name, *args, &block)
        bengali_method = Kolom::KEYWORDS.key(method_name.to_s)
        if bengali_method
          send(Kolom::KEYWORDS[bengali_method].to_sym, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        Kolom::KEYWORDS.key(method_name.to_s) || super
      end
    end
  end
end

# Extend core Ruby classes to respond to Bengali method names
class String
  include Kolom::CoreExtensions::StringMethods
end

class Array
  include Kolom::CoreExtensions::ArrayMethods
end

class Hash
  include Kolom::CoreExtensions::HashMethods
end
