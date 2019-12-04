# frozen_string_literal: true

RSpec.describe Command::Command::Core, type: :concern do
  include_context "with an example command"

  it { is_expected.to delegate_method(:executable_class).to(:class) }

  it { is_expected.to delegate_method(:malfunction).to(:executable) }
  it { is_expected.to delegate_method(:malfunction?).to(:executable) }

  describe "#initialize" do
    let(:sample_input) { Hash["foo", :foo, "bar", :bar] }

    context "with a custom executable" do
      let(:input) { sample_input }

      before do
        allow(example_executable_class).to receive(:new).and_call_original

        example_command
      end

      it "was called with options" do
        expect(example_executable_class).to have_received(:new).with(**sample_input.symbolize_keys)
        expect(example_command.__send__(:executable)).to be_an_instance_of example_executable_class
      end
    end

    context "with a flow executable" do
      include_context "with an example command having flow" do
        let(:input) { sample_input }
      end

      before do
        allow(example_flow_class).to receive(:new).and_call_original
        example_state_class.__send__(:option, :foo)
        example_state_class.__send__(:option, :bar)

        example_command
      end

      it "was called with options" do
        expect(example_flow_class).to have_received(:new).with(**sample_input.symbolize_keys)
        expect(example_command.__send__(:executable)).to be_an_instance_of example_flow_class
        expect(example_command.__send__(:executable).state).to be_an_instance_of example_state_class
      end
    end

    context "with a batch executable" do
      include_context "with an example command having batch" do
        let(:input) { sample_input }
      end

      before do
        allow(example_batch_class).to receive(:new).and_call_original
        example_batch_collection_class.__send__(:option, :foo)
        example_batch_collection_class.__send__(:option, :bar)

        example_command
      end

      it "was called with options" do
        expect(example_batch_class).to have_received(:new).with(**sample_input.symbolize_keys)
        expect(example_command.__send__(:executable)).to be_an_instance_of example_batch_class
        expect(example_command.__send__(:executable).collection).to be_an_instance_of example_batch_collection_class
      end
    end
  end
end
