# frozen_string_literal: true

module Command
  module Command
    module Failure
      extend ActiveSupport::Concern

      included do
        define_callbacks_with_handler :failure
      end

      private

      def failure_response
        resolve_as :unprocessable_entity
      end

      def handle_failure
        run_callbacks(:failure) { failure_response }
      end
    end
  end
end
