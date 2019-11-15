# frozen_string_literal: true

RSpec.describe Command::Command::Success, type: :concern do
  include_context "with an example command having flow"

  describe "#handle_success" do
    it_behaves_like "a handler for the callback" do
      subject(:run) { instance.__send__(:handle_success) }

      let(:example_class) { Command::CommandBase }
      let(:example_command_class) { test_class }
      let(:callback) { :success }
      let(:method) { :on_success }
    end
  end
end
