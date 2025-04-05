module Kolom
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