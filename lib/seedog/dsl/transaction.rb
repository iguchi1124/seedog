module Seedog
  class DSL
    class Transaction
      def initialize(&block)
        ActiveRecord::Base.transaction(&block)
      end
    end
  end
end
