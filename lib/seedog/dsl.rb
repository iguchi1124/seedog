require 'seedog/dsl/context'
require 'seedog/dsl/table'
require 'seedog/dsl/record'

module Seedog
  class DSL
    def initialize(file)
      @file = file
      @context = Context.new
    end

    def exec(dry_run: false)
      unless dry_run
        instance_eval @file.read
      end
    end

    class ParseError < StandardError
    end

    private

    def table(name, &block)
      table = Table.new(name)
      @context.call(table) { table.(&block) }
    end

    def record(upsert_attributes, &block)
      unless @context.head === Table
        raise ParseError
      end

      record = Record.new(
        @context.head,
        upsert_attributes
      )

      @context.call(record) { record.(&block) }
    end
  end
end
