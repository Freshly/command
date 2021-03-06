# frozen_string_literal: true

RSpec.describe Command::CommandBase, type: :command do
  include_context "with an example command having flow"

  it { is_expected.to inherit_from Spicerack::RootObject }

  it { is_expected.to include_module Conjunction::Conjunctive }

  it { is_expected.to include_module Command::Command::Core }
  it { is_expected.to include_module Command::Command::Success }
  it { is_expected.to include_module Command::Command::Failure }
  it { is_expected.to include_module Command::Command::Execute }
  it { is_expected.to include_module Command::Command::Resolution }
end
