# frozen_string_literal: true

RSpec.describe Command::Command::Executable, type: :concern do
  include_context "with an example command having flow"

  it { is_expected.to delegate_method(:_executable_methods).to(:class) }
  it { is_expected.to delegate_method(:_executable_classes).to(:class) }

  describe ".inherited" do
    it "needs specs"
  end

  describe "._executable_classes" do
    it "needs specs"
  end

  describe ".implicit_executable_class" do
    it "needs specs"
  end

  describe ".register_executable" do
    it "needs specs"
  end

  describe "#execution_method" do
    it "needs specs"
  end

  describe "#executable_base_class" do
    it "needs specs"
  end
end
