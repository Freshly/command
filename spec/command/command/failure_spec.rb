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

    context "without #failure_response" do
      it { is_expected.to be_nil }
    end

    context "with #failure_response" do
      let(:example_command_class) do
        Class.new(Command::CommandBase) do
          def failure_response
            :some_failure_response
          end
        end
      end

      it { is_expected.to eq :some_failure_response }
    end
  end
end
