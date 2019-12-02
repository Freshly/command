# frozen_string_literal: true

RSpec.describe Command::Command::Success, type: :concern do
  include_context "with an example command having flow"

  describe "#handle_success" do
    subject(:handle_success) { example_command.__send__(:handle_success) }

    it_behaves_like "a handler for the callback" do
      subject(:run) { instance.__send__(:handle_success) }

      let(:example_class) { Command::CommandBase }
      let(:example_command_class) { test_class }
      let(:callback) { :success }
      let(:method) { :on_success }
    end

    context "without #success_response" do
      it { is_expected.to be_nil }
    end

    context "with #success_response" do
      let(:example_command_class) do
        Class.new(Command::CommandBase) do
          def success_response
            :some_success_response
          end
        end
      end

      it { is_expected.to eq :some_success_response }
    end
  end
end
