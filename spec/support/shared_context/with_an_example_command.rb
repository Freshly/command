# frozen_string_literal: true

RSpec.shared_context "with an example command" do
  subject(:example_command) { example_command_class.new(input) }

  let(:example_command_class) { Class.new(Command::CommandBase) }

  let(:example_command_name) do
    Array.new(2) { Faker::Internet.domain_word.capitalize }.join("")
  end

  let(:input) { {} }

  before { stub_const(example_command_name, example_command_class) }
end
