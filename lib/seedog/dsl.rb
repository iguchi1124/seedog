require 'seedog/dsl/table'
require 'seedog/dsl/record'

module Seedog
  class DSL
    def initialize(file)
      @file = file
    end

    def exec(dry_run: false)
      unless dry_run
        instance_eval @file.read
      end
    end

    private

    def table(name, &block)
      table = Table.new(name)
      table.(&block)
    end
  end
end
