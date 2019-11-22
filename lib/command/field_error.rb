# frozen_string_literal: true

module Command
  class FieldError < Spicerack::InputObject
    argument :field_name
    argument :error_code

    def ==(other)
      super || other.try(:field_name) == field_name && other.try(:error_code) == error_code
    end
    alias_method :eql?, :==
  end
end
