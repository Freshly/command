# frozen_string_literal: true

module Command
  module Command
    module Core
      extend ActiveSupport::Concern

      included do
        delegate :executable_class, to: :class
        delegate :malfunction, :malfunction?, to: :executable

        private

        attr_reader :executable
      end

      def initialize(input = {})
        raise UnknownExecutableError if executable_class.blank?

        @executable = executable_class.new(**input.symbolize_keys)
      end
    end
  end
end
