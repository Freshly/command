# frozen_string_literal: true

module Command
  module Command
    module Execute
      extend ActiveSupport::Concern

      included do
        define_callbacks_with_handler :execute
      end

      class_methods do
        def execute(input = {})
          new(input).tap(&:execute)
        end
      end

      def execute
        run_callbacks(:execute) do
          execute!

          (malfunction? ? handle_failure : handle_success).presence || !malfunction?
        end
      end
    end
  end
end
