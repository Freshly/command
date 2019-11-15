# frozen_string_literal: true

module Command
  module Command
    module Core
      extend ActiveSupport::Concern

      included do
        delegate :flow_class, to: :class
        delegate :pending?, :triggered?, :success?, :failed?, :state, to: :flow, prefix: true

        private

        attr_reader :flow
      end

      class_methods do
        def flow_class
          conjugate!(Flow::FlowBase)
        end
      end

      def initialize(input = {})
        @flow = flow_class.new(**input.symbolize_keys)
      end
    end
  end
end
