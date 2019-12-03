# frozen_string_literal: true

module Command
  module Command
    module Resolution
      extend ActiveSupport::Concern

      included do
        on_execute { raise CommandUnresolvedError unless resolved? }
      end

      attr_reader :status

      def resolved?
        status.present?
      end

      private

      def resolve_as(status)
        raise ArgumentError, "#{self.class.name} command already resolved" if resolved?

        @status = status
      end
    end
  end
end
