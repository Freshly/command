# frozen_string_literal: true

module Command
  module Command
    module Success
      extend ActiveSupport::Concern

      included do
        define_callbacks_with_handler :success
      end

      private

      def handle_success
        run_callbacks(:success) { try(:success_response) }
      end
    end
  end
end
