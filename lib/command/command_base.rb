# frozen_string_literal: true

require_relative "command/executable"
require_relative "command/core"
require_relative "command/success"
require_relative "command/failure"
require_relative "command/execute"
require_relative "command/resolution"

module Command
  class CommandBase < Spicerack::RootObject
    include Conjunction::Conjunctive

    include Command::Executable
    include Command::Core
    include Command::Success
    include Command::Failure
    include Command::Execute
    include Command::Resolution

    register_executable Flow::FlowBase, :trigger
    register_executable BatchProcessor::BatchBase, :process
  end
end
