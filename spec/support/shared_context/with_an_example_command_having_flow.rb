# frozen_string_literal: true

RSpec.shared_context "with an example command having flow" do
  subject(:example_command) { example_command_class.new(input) }

  let(:example_command_class) { Class.new(Command::CommandBase) }
  let(:example_flow_class) { Class.new(Flow::FlowBase) }
  let(:example_state_class) { Class.new(Flow::StateBase) }

  let(:example_command_name) do
    Array.new(2) { Faker::Internet.domain_word.capitalize }.join("")
  end
  let(:example_flow_name) { "#{example_command_name}Flow" }
  let(:example_state_name) { "#{example_command_name}State" }

  let(:input) { {} }

  before do
    stub_const(example_command_name, example_command_class)
    stub_const(example_flow_name, example_flow_class)
    stub_const(example_state_name, example_state_class)
  end
end
