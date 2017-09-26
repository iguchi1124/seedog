module Seedog
  class DSL
    class Record
      def initialize(evaluator, model, upsert_attributes)
        @evaluator = evaluator
        @model = model
        @upsert_attributes = upsert_attributes
      end

      def call(&block)
        attrs = {}
        @model.model_class.attribute_names.each do |attr|
          define_singleton_method(attr) do |value|
            attrs[attr] = value
          end
        end

        instance_exec(&block) if block

        before_attrs = instance.attributes.slice(*attrs.keys)
        if instance.new_record?
          puts "Create new #{@model.model_class.name.downcase} #{@upsert_attributes.merge(attrs)}"
        elsif before_attrs != attrs
          puts "Update #{@model.model_class.name.downcase} #{@upsert_attributes.merge(before_attrs)} => #{@upsert_attributes.merge(attrs)}"
        end

        unless @evaluator.dry_run
          instance.assign_attributes(attrs)
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
