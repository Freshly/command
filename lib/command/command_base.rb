# frozen_string_literal: true

require_relative "command/core"

module Command
  class CommandBase < Spicerack::RootObject
    include Conjunction::Conjunctive

    include Command::Core
  end
end
