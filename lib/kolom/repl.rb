require "readline"

module Kolom
  class REPL

    def initialize
      @interpreter = Interpreter.new
    end
    
    def start
      loop do
        line = Readline.readline("কলম> ", true)
        break if line.nil? || line.strip == "বাহির"
        
        begin
          result, output = @interpreter.evaluate(line)
          puts output unless output.empty?
          puts "=> #{result.inspect}" unless result.nil?
        rescue => e
          puts "Error: #{e.message}"
          puts e.backtrace.join("\n")
        end
      end
      puts "ধন্যবাদ!"
    end
  end
end