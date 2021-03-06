# frozen_string_literal: true

require_relative "command/core"
require_relative "command/success"
require_relative "command/failure"
require_relative "command/execute"
require_relative "command/resolution"

module Command
  class CommandBase < Spicerack::RootObject
    include Conjunction::Conjunctive

    include Command::Core
    include Command::Success
    include Command::Failure
    include Command::Execute
    include Command::Resolution
  end
end
