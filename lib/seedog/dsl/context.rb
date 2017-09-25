module Seedog
  class DSL
    class Context
      def initialize
        @stack = []
      end

      def call(context)
        @stack.push(context)
        yield
        @stack.pop
      end

      def push(context)
        @stack.push(context)
      end

      def pop
        @stack.pop
      end

      def head
        @stack.last
      end
    end
  end
end
