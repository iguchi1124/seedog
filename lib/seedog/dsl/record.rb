module Seedog
  class DSL
    class Record
      def initialize(evaluator, model, upsert_attributes)
        @evaluator = evaluator
        @model = model
        @upsert_attributes = upsert_attributes
        @attrs = {}.with_indifferent_access
      end

      def method_missing(method, arg)
        @attrs[method] = arg
      end

      def call(&block)
        instance_exec(&block) if block

        before_attrs = instance.attributes.with_indifferent_access.slice(*@attrs.keys)

        if instance.new_record?
          puts "\33[32mCreate #{@model.model_class.name.underscore} #{@upsert_attributes.merge(@attrs)}\33[0m"
        elsif before_attrs != @attrs
          puts "Update #{@model.model_class.name.underscore} #{@upsert_attributes.merge(before_attrs)} to #{@upsert_attributes.merge(@attrs)}"
        end

        unless @evaluator.dry_run
          instance.assign_attributes(@attrs)
          instance.save!(validate: @evaluator.config.validate)
        end
      end

      private

      def instance
        @instance ||= @model.model_class.find_or_initialize_by(@upsert_attributes)
      end
    end
  end
end
