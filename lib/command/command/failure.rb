# frozen_string_literal: true

module Command
  module Command
    module Failure
      extend ActiveSupport::Concern

      included do
        define_callbacks_with_handler :failure
      end

      private

      def handle_failure
        run_callbacks(:failure)
      end
    end
  end
end
