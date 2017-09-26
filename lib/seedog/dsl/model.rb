module Seedog
  class DSL
    class Model
      attr_reader :model_class

      def initialize(evaluator, model_class)
        @evaluator = evaluator
        @model_class = model_class
      end

      def call(&block)
        instance_exec(&block)
      end

      private

      def record(upsert_attributes, &block)
        record = Record.new(@evaluator, self, upsert_attributes)
        record.(&block)
      end
    end
  end
end
