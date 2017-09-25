module Seedog
  class DSL
    class Table
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def call
        yield
      end

      def model_class
        @model_class ||= eval(name.to_s.classify)
      end

      alias_method :===, :is_a?
    end
  end
end
