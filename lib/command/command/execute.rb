# frozen_string_literal: true

module Command
  module Command
    module Execute
      extend ActiveSupport::Concern

      included do
        define_callbacks_with_handler :execute
      end

      class_methods do
        def execute(input = {})
          new(input).tap(&:execute)
        end

        def executable_class
          @executable_class || implicit_executable_class
        end

        def inherited(base)
          base.executes(@executable_class) if defined?(@executable_class)
          super
        end

        protected

        def executes(executable_class)
          raise UnregisteredExecutableError unless _executable_classes.any?(&executable_class.method(:<=))

          @executable_class = executable_class
        end
      end

      def execute
        run_callbacks(:execute) do
          execute!

          (malfunction? ? handle_failure : handle_success).presence || !malfunction?
        end
      end

      private

      def execute!
        raise UnknownExecutableError if execution_method.blank?

        executable.public_send(execution_method)
      end
    end
  end
end
