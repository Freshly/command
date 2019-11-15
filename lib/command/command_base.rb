# frozen_string_literal: true

module Command
  class CommandBase < Spicerack::RootObject
    include Conjunction::Conjunctive
  end
end
