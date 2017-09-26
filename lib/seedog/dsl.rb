require 'seedog/dsl/record'
require 'seedog/dsl/table'
require 'seedog/dsl/transaction'

module Seedog
  class DSL
    def initialize(evaluator)
      @evaluator = evaluator
    end

    private

    def table(name, &block)
      table = Table.new(@evaluator, name)
      table.(&block)
    end

    def transaction
      Transaction.new { yield }
    end
  end
end
