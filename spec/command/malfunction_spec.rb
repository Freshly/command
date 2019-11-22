# frozen_string_literal: true

RSpec.describe Command::Malfunction, type: :malfunction do
  include_context "with an example command having flow"

  subject(:example_malfunction) do
    example_command.__send__(:handle_failure)
    example_command.malfunction
  end

  it { is_expected.to inherit_from Spicerack::RootObject }

  it { is_expected.to delegate_method(:flow_state).to(:command) }

  describe "#command" do
    subject { example_malfunction.command }

    it { is_expected.to eq example_command }
  end

  describe "#problem" do
    subject { example_malfunction.problem }

    context "with state errors" do
      let(:example_state_class) do
        Class.new(Flow::StateBase) do
          option :username
          validates :username, presence: true
        end
      end

      before { example_command.execute }

      it { is_expected.to eq :invalid_state }
    end

    context "with operation failure" do
      let(:problem) { Faker::Internet.domain_word.to_sym }
      let(:operation_failure) { instance_double(Flow::Operation::Failures::OperationFailure, problem: problem) }

      before { allow(example_command).to receive(:operation_failure).and_return(operation_failure) }

      it { is_expected.to eq problem }
    end

    context "without either" do
      it { is_expected.to eq :unknown_error }
    end
  end

  describe "#details" do
    subject { example_malfunction.details }

    context "with state errors" do
      let(:example_state_class) do
        Class.new(Flow::StateBase) do
          option :username
          validates :username, presence: true
        end
      end

      before { example_command.execute }

      it { is_expected.to eq(field_errors: [ Command::FieldError.new(field_name: :username, error_code: :blank) ]) }
    end

    context "with operation failure" do
      let(:details) { Hash[*Faker::Lorem.words(2 * rand(1..2))] }
      let(:operation_failure) { instance_double(Flow::Operation::Failures::OperationFailure, details: details) }

      before { allow(example_command).to receive(:operation_failure).and_return(operation_failure) }

      it { is_expected.to eq details }

      context "with extra field errors" do
        let(:field_errors) { [ Command::FieldError.new(field_name: :other_field_name, error_code: :other_error_code) ] }

        before { example_malfunction.add_field_error :other_field_name, :other_error_code }

        it { is_expected.to eq details.merge(field_errors: field_errors) }
      end
    end

    context "without either" do
      it { is_expected.to be_empty }
    end
  end

  describe "#field_errors?" do
    before { allow(example_malfunction).to receive(:field_errors).and_return(field_errors) }

    context "with field errors" do
      let(:field_errors) { [ double ] }

      it { is_expected.to be_field_errors }
    end

    context "without field errors" do
      let(:field_errors) { [] }

      it { is_expected.not_to be_field_errors }
    end
  end

  describe "#field_errors" do
    subject { example_malfunction.field_errors }

    context "without state errors" do
      it { is_expected.to be_blank }
    end

    context "with state errors" do
      let(:example_state_class) do
        Class.new(Flow::StateBase) do
          option :username
          option :password
          validates :username, presence: true
          validates :password, presence: true
        end
      end

      let(:no_username_error) { Command::FieldError.new(field_name: :username, error_code: :blank) }
      let(:no_password_error) { Command::FieldError.new(field_name: :password, error_code: :blank) }

      before { example_command.execute }

      context "with multiple errors" do
        it { is_expected.to eq [ no_username_error, no_password_error ] }
      end

      context "with one error" do
        let(:input) { Hash[:username, SecureRandom.hex] }

        it { is_expected.to eq [ no_password_error ] }
      end
    end
  end
end
