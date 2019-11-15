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

  describe "#execute" do
    subject(:execute) { example_command.execute }

    let(:flow) { example_command.__send__(:flow) }

    before do
      allow(flow).to receive(:trigger)
      allow(flow).to receive(:success?).and_return(flow_success?)
      allow(example_command).to receive(expected_handler)
    end

    shared_examples_for "the expected handler is called" do
      it "triggers and handles" do
        execute
        expect(flow).to have_received(:trigger)
        expect(example_command).to have_received(expected_handler)
      end
    end

    context "with flow_success?" do
      let(:flow_success?) { true }
      let(:expected_handler) { :handle_success }

      it_behaves_like "the expected handler is called"
    end

    context "without flow_success?" do
      let(:flow_success?) { false }
      let(:expected_handler) { :handle_failure }

      it_behaves_like "the expected handler is called"
    end
  end
end