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
        run_callbacks(:success)
      end
    end
  end
end
