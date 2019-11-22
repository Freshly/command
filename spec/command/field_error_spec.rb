# frozen_string_literal: true

RSpec.describe Command::FieldError, type: :field_error do
  subject(:field_error) { described_class.new(field_name: field_name, error_code: error_code) }

  let(:field_name) { Faker::Internet.domain_word }
  let(:error_code) { Faker::Internet.domain_word }

  it { is_expected.to inherit_from Spicerack::InputObject }

  it { is_expected.to define_argument :field_name }
  it { is_expected.to define_argument :error_code }

  it { is_expected.to alias_method(:eql?, :==) }

  describe "#field_name" do
    subject { field_error.field_name }

    it { is_expected.to eq field_name }
  end

  describe "#error_code" do
    subject { field_error.error_code }

    it { is_expected.to eq error_code }
  end

  describe "#==" do
    context "when other is nil" do
      let(:other) { nil }

      it { is_expected.not_to eq other }
    end

    context "when other is nonsense" do
      let(:other) { SecureRandom.hex }

      it { is_expected.not_to eq other }
    end

    context "when blank other" do
      let(:other) { described_class.new(field_name: nil, error_code: nil) }

      it { is_expected.not_to eq other }
    end

    context "when other with different data" do
      let(:other) { described_class.new(field_name: error_code, error_code: field_name) }

      it { is_expected.not_to eq other }
    end

    context "when other with same data" do
      let(:other) { described_class.new(field_name: field_name, error_code: error_code) }

      it { is_expected.to eq other }
    end

    context "when other is exactly the same" do
      let(:other) { field_error }

      it { is_expected.to eq other }
    end
  end
end
