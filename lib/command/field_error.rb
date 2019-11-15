# frozen_string_literal: true

module Command
  class FieldError < Spicerack::InputObject
    argument :field_name
    argument :error_code
    argument :message

    class << self
      def collection_from_json(field_error_hashes)
        field_error_hashes.map { |field_error_hash| new(**field_error_hash.symbolize_keys) }
      end
    end
  end
end
