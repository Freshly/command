# frozen_string_literal: true

RSpec.shared_context "with an example command" do
  subject(:example_command) { example_command_class.new(input) }

  let(:example_command_class) do
    Class.new(Command::CommandBase).tap do |klass|
      klass.__send__(:register_executable, example_executable_base_class, executable_method_name)
      klass.__send__(:executes, example_executable_class)
    end
  end
  let(:example_executable_base_class) do
    Class.new.tap do |klass|
      klass.define_method(:initialize) { |*| }
      klass.define_method(executable_method_name) {}
    end
  end
  let(:example_executable_class) { Class.new(example_executable_base_class) }
  let(:executable_method_name) { Faker::Internet.domain_word.to_sym }

  let(:example_command_name) do
    Array.new(2) { Faker::Internet.domain_word.capitalize }.join("")
  end

  let(:input) { {} }

  before { stub_const(example_command_name, example_command_class) }
end
