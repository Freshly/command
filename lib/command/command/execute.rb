# frozen_string_literal: true

module Command
  module Command
    module Execute
      extend ActiveSupport::Concern

      class_methods do
        def execute(input = {})
          new(input).tap(&:execute)
        end
      end

      def execute
        flow.trigger

        (malfunction? ? handle_failure : handle_success).presence || !malfunction?
      end
    end
  end
end
