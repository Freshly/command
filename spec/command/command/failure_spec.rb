# frozen_string_literal: true

RSpec.describe Command::Command::Failure, type: :concern do
  include_context "with an example command having flow"

  describe "#handle_failure" do
    subject(:handle_failure) { example_command.__send__(:handle_failure) }

    it_behaves_like "a handler for the callback" do
      subject(:run) { instance.__send__(:handle_failure) }

      let(:example_class) { Command::CommandBase }
      let(:example_command_class) { test_class }
      let(:callback) { :failure }
      let(:method) { :on_failure }
    end

    it "sets malfunction" do
      expect { handle_failure }.to change { example_command.malfunction }.to(an_instance_of(Command::Malfunction))
    end
  end

  describe "#malfunction?" do
    context "with malfunction" do
      before { example_command.__send__(:handle_failure) }

      it { is_expected.to be_malfunction }
    end

    context "without malfunction" do
      it { is_expected.not_to be_malfunction }
    end
  end
end
