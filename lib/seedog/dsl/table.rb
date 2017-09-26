module Seedog
  class DSL
    class Table
      attr_reader :name

      def initialize(evaluator, name)
        @evaluator = evaluator
        @name = name
      end

      def call(&block)
        instance_exec(&block)
      end

      def model_class
        @model_class ||= eval(name.to_s.classify)
      end

      private

      def record(upsert_attributes, &block)
        record = Record.new(@evaluator, self, upsert_attributes)
        record.(&block)
      end
    end
  end
end
