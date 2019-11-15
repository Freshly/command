# frozen_string_literal: true

RSpec.describe Command do
  it "has a version number" do
    expect(Command::VERSION).not_to be nil
  end
end
