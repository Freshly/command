# frozen_string_literal: true

RSpec.describe Command::Command::Execute, type: :concern do
  include_context "with an example command having flow"

  describe ".execute" do
    subject(:execute) { example_command_class.execute(input) }

    let(:input) { Hash["foo", :foo, "bar", :bar] }
    let(:command) { instance_double(Command::CommandBase) }

    before do
      allow(example_command_class).to receive(:new).with(input).and_return(command)
      allow(command).to receive(:execute)
    end

    it { is_expected.to eq command }

    it "calls execute" do
      execute
      expect(command).to have_received(:execute)
    end
  end

  describe ".executable_class" do
    subject { example_command_class.executable_class }

    context "when explicit" do
      let(:explicit_class) { Class.new(Flow::FlowBase) }

      before { example_command_class.__send__(:executes, explicit_class) }

      it { is_expected.to eq explicit_class }
    end

    context "when implied" do
      let(:implicit_class) { Class.new(Flow::FlowBase) }

      before { allow(example_command_class).to receive(:implicit_executable_class).and_return(implicit_class) }

      it { is_expected.to eq implicit_class }
    end
  end

  describe ".inherited" do
    it "needs specs"
  end

  describe ".executes" do
    it "needs specs"
  end

  describe "#execute" do
    subject(:execute) { example_command.execute }

    before do
      allow(example_command).to receive(:execute!)
      allow(example_command).to receive(:malfunction?).and_return(malfunction?)
    end

    shared_examples_for "the expected handler is called" do
      before { allow(example_command).to receive(expected_handler).and_call_original }

      it "triggers and handles" do
        execute
        expect(example_command).to have_received(:execute!)
        expect(example_command).to have_received(expected_handler)
      end
    end

    it_behaves_like "a handler for the callback" do
      subject(:run) { instance.__send__(:execute) }

      let(:malfunction?) { false }
      let(:example_class) { Command::CommandBase }
      let(:example_command_class) { test_class }
      let(:callback) { :execute }
      let(:method) { :on_execute }

      before { allow(instance).to receive(:execute!) }
    end

    context "without malfunction?" do
      let(:malfunction?) { false }
      let(:expected_handler) { :handle_success }

      it_behaves_like "the expected handler is called"

      context "when unresolved" do
        let(:example_command_class) do
          Class.new(Command::CommandBase) do
            def success_response
              nil
            end
          end
        end

        it "raises" do
          expect { execute }.to raise_error Command::CommandUnresolvedError
        end
      end

      context "when resolved" do
        context "with default" do
          it { is_expected.to eq :ok }

          it "changes status" do
            expect { execute }.to change { example_command.status }.to(:ok)
          end
        end

        context "with nil #success_response" do
          let(:example_command_class) do
            Class.new(Command::CommandBase) do
              def success_response
                super
                nil
              end
            end
          end

          it { is_expected.to eq true }
        end

        context "with #success_response" do
          let(:example_command_class) do
            Class.new(Command::CommandBase) do
              def success_response
                super
                :some_success_response
              end
            end
          end

          it { is_expected.to eq :some_success_response }
        end
      end
    end

    context "with malfunction?" do
      let(:malfunction?) { true }
      let(:expected_handler) { :handle_failure }

      it_behaves_like "the expected handler is called"

      context "when unresolved" do
        let(:example_command_class) do
          Class.new(Command::CommandBase) do
            def failure_response
              nil
            end
          end
        end

        it "raises" do
          expect { execute }.to raise_error Command::CommandUnresolvedError
        end
      end

      context "when resolved" do
        context "with default" do
          it { is_expected.to eq :unprocessable_entity }

          it "changes status" do
            expect { execute }.to change { example_command.status }.to(:unprocessable_entity)
          end
        end

        context "with nil #failure_response" do
          let(:example_command_class) do
            Class.new(Command::CommandBase) do
              def failure_response
                super
                nil
              end
            end
          end

          it { is_expected.to eq false }
        end

        context "with #failure_response" do
          let(:example_command_class) do
            Class.new(Command::CommandBase) do
              def failure_response
                super
                :some_failure_response
              end
            end
          end

          it { is_expected.to eq :some_failure_response }
        end
      end
    end
  end

  describe "#execute!" do
    it "needs specs"
  end
end
