# frozen_string_literal: true

require "active_support"

require "spicery"

require "flow"
require "batch_processor"

require "command/version"

require "command/field_error"
require "command/command_base"

module Command
  class Error < StandardError; end

  class CommandUnresolvedError < Error; end
  class UnknownExecutableError < Error; end
  class UnregisteredExecutableError < Error; end
end
