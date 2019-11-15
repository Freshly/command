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

        flow_success? ? handle_success : handle_failure
      end
    end
  end
end
