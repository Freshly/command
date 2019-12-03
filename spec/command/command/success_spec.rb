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
      it { is_expected.to eq :ok }
    end

    context "with #success_response" do
      context "with custom resolution" do
        let(:example_command_class) do
          Class.new(Command::CommandBase) do
            def success_response
              resolve_as :some_success_status
            end
          end
        end

        it { is_expected.to eq :some_success_status }

        it "sets status" do
          expect { handle_success }.to change { example_command.status }.to(:some_success_status)
        end
      end

      context "with default resolution" do
        let(:example_command_class) do
          Class.new(Command::CommandBase) do
            def success_response
              super
              :some_success_response
            end
          end
        end

        it { is_expected.to eq :some_success_response }

        it "sets status" do
          expect { handle_success }.to change { example_command.status }.to(:ok)
        end
      end
    end
  end
end
