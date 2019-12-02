# frozen_string_literal: true

RSpec.describe Command::Command::Core, type: :concern do
  include_context "with an example command having flow"

  it { is_expected.to delegate_method(:flow_class).to(:class) }

  it { is_expected.to delegate_method(:malfunction).to(:flow) }
  it { is_expected.to delegate_method(:malfunction?).to(:flow) }

  describe ".flow_class" do
    subject { example_command_class.flow_class }

    let(:example_flow_class) { Class.new(Flow::FlowBase) }
    let(:example_flow_name) { "#{example_command_name}Flow" }

    before { stub_const(example_flow_name, example_flow_class) }

    it { is_expected.to eq example_flow_class }
  end

  describe "#initialize" do
    let(:input) { Hash["foo", :foo, "bar", :bar] }

    before do
      allow(example_flow_class).to receive(:new).and_call_original
      example_state_class.__send__(:option, :foo)
      example_state_class.__send__(:option, :bar)

      example_command
    end

    it "was called with options" do
      expect(example_flow_class).to have_received(:new).with(foo: :foo, bar: :bar)
      expect(example_command.__send__(:flow)).to be_an_instance_of example_flow_class
      expect(example_command.__send__(:flow).state).to be_an_instance_of example_state_class
    end
  end
end
