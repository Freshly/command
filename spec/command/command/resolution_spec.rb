# frozen_string_literal: true

RSpec.describe Command::Command::Resolution, type: :concern do
  include_context "with an example command having flow"

  describe "#resolved?" do
    subject { example_command }

    context "with status" do
      before { allow(example_command).to receive(:status).and_return(:status) }

      it { is_expected.to be_resolved }
    end

    context "without status" do
      it { is_expected.not_to be_resolved }
    end
  end

  describe "#resolve_as" do
    subject(:resolve_as) { example_command.__send__(:resolve_as, status) }

    let(:status) { Faker::Internet.domain_word.to_sym }

    context "when unresolved" do
      it "resolves command" do
        expect { resolve_as }.to change { example_command.status }.to(status)
      end
    end

    context "when resolved" do
      before { allow(example_command).to receive(:status).and_return(:status) }

      it "raises" do
        expect { resolve_as }.to raise_error ArgumentError, "#{example_command_name} command already resolved"
      end
    end
  end
end
