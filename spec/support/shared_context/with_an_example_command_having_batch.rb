# frozen_string_literal: true

RSpec.shared_context "with an example command having batch" do
  subject(:example_command) { example_command_class.new(input) }

  let(:example_command_class) { Class.new(Command::CommandBase) }
  let(:example_batch_class) { Class.new(BatchProcessor::BatchBase) }
  let(:example_batch_collection_class) { Class.new(BatchProcessor::BatchBase::BatchCollection) }

  let(:example_command_name) do
    Array.new(2) { Faker::Internet.domain_word.capitalize }.join("")
  end
  let(:example_batch_name) { "#{example_command_name}Batch" }
  let(:example_batch_collection_name) { "#{example_batch_name}::Collection" }

  let(:input) { {} }

  before do
    stub_const(example_command_name, example_command_class)
    stub_const(example_batch_name, example_batch_class)
    stub_const(example_batch_collection_name, example_batch_collection_class)
  end
end
