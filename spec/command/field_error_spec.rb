# frozen_string_literal: true

RSpec.describe Command::FieldError, type: :field_error do
  subject { described_class }

  let(:instance) { described_class.new(**input_hash) }
  let(:input_hash) do
    { field_name: field_name, error_code: error_code, message: message }
  end
  let(:field_name) { Faker::Lorem.word }
  let(:error_code) { Faker::Lorem.word }
  let(:message) { Faker::Lorem.sentence }

  it { is_expected.to inherit_from Spicerack::InputObject }

  it { is_expected.to define_argument :field_name }
  it { is_expected.to define_argument :error_code }
  it { is_expected.to define_argument :message }

  describe ".collection_from_json" do
    subject { described_class.collection_from_json field_error_hashes }

    let(:field_error_hashes) { [ input_hash ] }

    before { allow(described_class).to receive(:new).with(input_hash).and_return(instance) }

    it { is_expected.to match_array [ instance ] }
  end

  describe "#field_name" do
    subject { instance.field_name }

    it { is_expected.to eq field_name }
  end

  describe "#error_code" do
    subject { instance.error_code }

    it { is_expected.to eq error_code }
  end

  describe "#message" do
    subject { instance.message }

    it { is_expected.to eq message }
  end
end
