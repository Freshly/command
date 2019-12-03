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
      it { is_expected.to eq :unprocessable_entity }
    end

    context "with #failure_response" do
      context "with custom resolution" do
        let(:example_command_class) do
          Class.new(Command::CommandBase) do
            def failure_response
              resolve_as :some_failure_status
            end
          end
        end

        it { is_expected.to eq :some_failure_status }

        it "sets status" do
          expect { handle_failure }.to change { example_command.status }.to(:some_failure_status)
        end
      end

      context "with default resolution" do
        let(:example_command_class) do
          Class.new(Command::CommandBase) do
            def failure_response
              super
              :some_failure_response
            end
          end
        end

        it { is_expected.to eq :some_failure_response }

        it "sets status" do
          expect { handle_failure }.to change { example_command.status }.to(:unprocessable_entity)
        end
      end
    end
  end
end
