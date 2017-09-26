module Seedog
  class DSL
    class Record
      def initialize(evaluator, table, upsert_attributes)
        @evaluator = evaluator
        @table = table
        @upsert_attributes = upsert_attributes
      end

      def call(&block)
        attrs = {}
        @table.model_class.attribute_names.each do |attr|
          define_singleton_method(attr) do |value|
            attrs[attr] = value
          end
        end

        instance_exec(&block) if block

        before_attrs = model.attributes.slice(*attrs.keys)
        if model.new_record?
          puts "Create new #{@table.name.to_s.singularize} #{@upsert_attributes.merge(attrs)}"
        elsif before_attrs != attrs
          puts "Update #{@table.name.to_s.singularize} #{@upsert_attributes.merge(before_attrs)} => #{@upsert_attributes.merge(attrs)}"
        end

        unless @evaluator.dry_run
          model.assign_attributes(attrs)
          model.save!(validate: @evaluator.config.validate)
        end
      end

      private

      def model
        @model ||= @table.model_class.find_or_initialize_by(@upsert_attributes)
      end
    end
  end
end
