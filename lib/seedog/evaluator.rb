require 'seedog/dsl'

module Seedog
  class Evaluator
    attr_reader :config, :dry_run
    attr_accessor :changed

    def initialize(config, dry_run: false)
      @config = config
      @dry_run = dry_run
      @changed = false
    end

    def run
      if dry_run
        puts "Apply `#{config.file.relative_path_from(Rails.root)}` (dry-run)"
      else
        puts "Apply `#{config.file.relative_path_from(Rails.root)}`"
      end

      dsl = DSL.new(self)
      dsl.instance_eval(config.file.read)

      unless changed
        puts 'No change'
      end
    end
  end
end
