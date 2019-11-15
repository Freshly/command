# frozen_string_literal: true

RSpec.describe Command::Command::Failure, type: :concern do
  include_context "with an example command having flow"

  describe "#handle_failure" do
    it_behaves_like "a handler for the callback" do
      subject(:run) { instance.__send__(:handle_failure) }

      let(:example_class) { Command::CommandBase }
      let(:example_command_class) { test_class }
      let(:callback) { :failure }
      let(:method) { :on_failure }
    end
  end
end
