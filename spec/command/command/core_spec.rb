# frozen_string_literal: true

RSpec.describe Command::Command::Core, type: :command do
  include_context "with an example command having flow"

  it { is_expected.to delegate_method(:flow_class).to(:class) }

  it { is_expected.to delegate_method(:pending?).to(:flow).with_prefix }
  it { is_expected.to delegate_method(:triggered?).to(:flow).with_prefix }
  it { is_expected.to delegate_method(:success?).to(:flow).with_prefix }
  it { is_expected.to delegate_method(:failed?).to(:flow).with_prefix }
  it { is_expected.to delegate_method(:state).to(:flow).with_prefix }

  describe ".flow_class" do
    subject { example_command_class.flow_class }

    let(:example_flow_class) { Class.new(Flow::FlowBase) }
    let(:example_flow_name) { "#{example_command_name}Flow" }

    before { stub_const(example_flow_name, example_flow_class) }

    it { is_expected.to eq example_flow_class }
  end
end
