require 'seedog/configuration'
require 'seedog/dsl'

require 'seedog/engine' if defined?(Rails)

module Seedog
  class << self
    def run
      dsl.exec
    end

    def dry_run
      dsl.exec(dry_run: true)
    end

    def config
      @config ||= Configuration.new
    end

    private

    def dsl
      DSL.new(config.file)
    end
  end
end
