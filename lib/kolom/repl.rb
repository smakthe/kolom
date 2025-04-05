require 'readline'

module Kolom
  class REPL

    def initialize
      @interpreter = Interpreter.new
      @history = []
    end
    
    def start
      loop do
        line = Readline.readline("#{ENV["NAME"]}> ", true)
        break if line.nil? || line.strip == 'বাহির'
        
        begin
          result, output = @interpreter.evaluate(line)
          puts output unless output.empty?
          puts "=> #{result.inspect}" unless result.nil?
        rescue => e
          puts "Error: #{e.message}"
          puts e.backtrace.join("\n")
        end
        
        @history << line
      end
      
      puts "ধন্যবাদ!"
    end
  end
  
  # Advanced features for metaprogramming
  module MetaProgramming
    # Dynamic method generation
    def self.define_dynamic_method(obj, method_name, &block)
      obj.define_singleton_method(method_name, &block)
    end
    
    # Method aliasing in Bengali
    def self.create_alias(obj, new_name, old_name)
      obj.singleton_class.class_eval do
        alias_method new_name.to_sym, old_name.to_sym
      end
    end
    
    # Method tracing for debugging
    def self.trace_method(klass, method_name)
      original_method = klass.instance_method(method_name)
      
      klass.class_eval do
        define_method(method_name) do |*args, &block|
          puts "Calling: #{method_name} with #{args.inspect}"
          result = original_method.bind(self).call(*args, &block)
          puts "Result: #{result.inspect}"
          result
        end
      end
    end
    
    # DSL support
    class DSLContext
      def initialize
        @data = {}
      end
      
      def method_missing(method_name, *args, &block)
        if block_given?
          @data[method_name] = instance_exec(&block)
        elsif args.size > 0
          @data[method_name] = args.size == 1 ? args.first : args
        else
          @data[method_name]
        end
      end
      
      def respond_to_missing?(method_name, include_private = false)
        true
      end
      
      def evaluate(&block)
        instance_eval(&block)
        @data
      end
    end
    
    def self.create_dsl(&block)
      context = DSLContext.new
      context.evaluate(&block)
    end
  end
  
  # AST manipulation for more complex language features
  class ASTTransformer
    def initialize
      # This would use the parser gem to handle real AST manipulation
    end
    
    def transform(code)
      # Parse and transform code
      # For now, we'll just return the code itself
      code
    end
    
    # This would implement more complex transformations in a real gem
  end
  
  # Add support for lazy evaluation using Fiber
  class LazyEvaluator
    def initialize(&block)
      @fiber = Fiber.new do
        result = block.call
        loop { Fiber.yield(result) }
      end
    end
    
    def value
      @fiber.resume
    end
  end
  
  # Add Thread support for concurrent execution
  class ConcurrentExecutor
    def initialize
      @threads = []
    end
    
    def execute(&block)
      thread = Thread.new(&block)
      @threads << thread
      thread
    end
    
    def join_all
      @threads.each(&:join)
    end
  end
end