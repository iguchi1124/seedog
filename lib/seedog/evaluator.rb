require 'seedog/dsl'

module Seedog
  class Evaluator
    attr_reader :config, :dry_run

    def initialize(config, dry_run: false)
      @config = config
      @dry_run = dry_run
    end

    def run
      dsl = DSL.new(self)
      dsl.instance_eval(config.file.read)
    end
  end
end
