module Seedog
  class DSL
    class Record
      def initialize(table, upsert_attributes)
        @table = table
        @upsert_attributes = upsert_attributes
      end

      def call(&block)
        @table.model_class.attribute_names.each do |attr|
          define_singleton_method(attr) do |value|
            model.send("#{attr}=", value)
          end
        end

        instance_exec(&block) if block

        model.save!
      end

      private

      def model
        @model ||= @table.model_class.find_or_initialize_by(@upsert_attributes)
      end
    end
  end
end
