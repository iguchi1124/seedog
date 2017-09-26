require 'seedog/configuration'
require 'seedog/evaluator'

require 'seedog/engine' if defined?(Rails)

module Seedog
  class << self
    def run
      evaluator = Evaluator.new(config)
      evaluator.run
    end

    def dry_run
      evaluator = Evaluator.new(config, dry_run: true)
      evaluator.run
    end

    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end
  end
end
