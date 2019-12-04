# frozen_string_literal: true

module Command
  module Command
    module Executable
      extend ActiveSupport::Concern

      included do
        class_attribute :_executable_methods, instance_writer: false, default: {}
        delegate :_executable_methods, :_executable_classes, to: :class

        memoize :executable_base_class
        memoize :execution_method
      end

      class_methods do
        def executable_class
          @executable_class || implicit_executable_class
        end

        def inherited(base)
          base._executable_methods = _executable_methods.dup
          base.executes(@executable_class) if defined?(@executable_class)
          super
        end

        protected

        def executes(executable_class)
          @executable_class = executable_class
        end

        private

        def _executable_classes
          _executable_methods.keys
        end

        def implicit_executable_class
          _executable_classes.each do |executable_class|
            conjugate = try(:conjugate, executable_class)
            return conjugate if conjugate.present?
          end

          nil
        end

        def register_executable(base_class, execution_method)
          raise TypeError, "#{base_class} is not a class" unless base_class.is_a?(Class)
          raise NameError, "#{execution_method} not defined" unless base_class.method_defined?(execution_method)

          _executable_methods[base_class] = execution_method
        end
      end

      private

      def execute!
        raise UnknownExecutableError if execution_method.blank?

        executable.public_send(execution_method)
      end

      def execution_method
        _executable_methods[executable_base_class] if executable_base_class.present?
      end

      def executable_base_class
        _executable_classes.find(&executable.method(:is_a?))
      end
    end
  end
end
