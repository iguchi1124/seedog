require 'seedog/dsl/record'
require 'seedog/dsl/model'
require 'seedog/dsl/transaction'

module Seedog
  class DSL
    def initialize(evaluator)
      @evaluator = evaluator
    end

    private

    def model(model_class, &block)
      model = Model.new(@evaluator, model_class)
      model.(&block)
    end

    def transaction
      Transaction.new { yield }
    end
  end
end
