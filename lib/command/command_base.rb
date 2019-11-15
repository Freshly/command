# frozen_string_literal: true

require_relative "command/core"
require_relative "command/success"

module Command
  class CommandBase < Spicerack::RootObject
    include Conjunction::Conjunctive

    include Command::Core
    include Command::Success
  end
end
