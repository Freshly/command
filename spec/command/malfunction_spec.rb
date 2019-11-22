# frozen_string_literal: true

RSpec.describe Command::Malfunction, type: :malfunction do
  include_context "with an example command having flow"

  subject(:example_malfunction) do
    example_command.__send__(:handle_failure)
    example_command.malfunction
  end

  describe "#command" do
    subject { example_malfunction.command }

    it { is_expected.to eq example_command }
  end
end
