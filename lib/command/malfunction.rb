# frozen_string_literal: true

module Command
  class Malfunction < Spicerack::RootObject
    attr_reader :command

    delegate :flow_state, :operation_failure, to: :command

    def initialize(command)
      @command = command
    end

    def problem
      return :invalid_state if flow_state.errors.present?

      operation_failure.try(:problem) || :unknown_error
    end
    memoize :problem

    def details
      { field_errors: field_errors.presence }.compact.merge(operation_failure&.details || {})
    end
    memoize :details

    def add_field_error(field_name, error_code)
      field_errors << FieldError.new(field_name: field_name, error_code: error_code)
    end

    def field_errors?
      field_errors.present?
    end

    def field_errors
      flow_state.errors.details.flat_map do |field, errors|
        errors.map { |error| FieldError.new(field_name: field, error_code: error[:error]) }
      end
    end
    memoize :field_errors
  end
end
