# frozen_string_literal: true

RSpec.describe Command do
  it "has a version number" do
    expect(Command::VERSION).not_to be nil
  end

  describe described_class::Error do
    it { is_expected.to inherit_from StandardError }
  end

  describe described_class::CommandUnresolvedError do
    it { is_expected.to inherit_from Command::Error }
  end
end
