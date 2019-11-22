# frozen_string_literal: true

module Command
  module Command
    module Failure
      extend ActiveSupport::Concern

      included do
        define_callbacks_with_handler :failure
        attr_reader :malfunction
      end

      def malfunction?
        malfunction.present?
      end

      private

      def handle_failure
        run_callbacks(:failure) { @malfunction = Malfunction.new(self) }
      end
    end
  end
end
