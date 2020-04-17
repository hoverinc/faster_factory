# FactoryBot and FactoryGirl are used in examples to help ensure
# that this works for older codebases that haven’t upgraded to FactoryBot too

RSpec.describe FasterFactory::Line do
  it "requires an initialization argument" do
    subject = FasterFactory::Line.new("asdf")

    expect(subject).not_to be nil
  end

  describe "#create_present?" do
    it "knows that .create is in its content" do
      line_with_create = "let(:user) { FactoryBot.create(:user) }"
      subject = FasterFactory::Line.new(line_with_create).create_present?

      expect(subject).to eq true
    end

    it "knows that .create is not in its content" do
      line_without_create = "let(:user) { FactoryBot.build(:user) }"
      subject = FasterFactory::Line.new(line_without_create).create_present?

      expect(subject).to eq false
    end
  end

  describe "#build_present?" do
    it "knows that .build is in its content" do
      line_with_build = "let(:user) { FactoryGirl.build(:user) }"
      subject = FasterFactory::Line.new(line_with_build).build_present?

      expect(subject).to eq true
    end

    it "knows that .build is not in its content" do
      line_without_build = "let(:user) { FactoryGirl.create(:user) }"
      subject = FasterFactory::Line.new(line_without_build).build_present?

      expect(subject).to eq false
    end
  end

  describe "#original_content" do
    it "sets #original_content from the content initialization argument" do
      line_content = "let(:user) { FactoryGirl.build(:user) }"
      subject = FasterFactory::Line.new(line_content).original_content

      expect(subject).to eq line_content
    end
  end

  describe "#replace_create_with_build!" do
    it "replaces '.create' with '.build' in #content" do
      line_with_create = "let(:user) { FactoryBot.create(:user) }"
      line_with_build = "let(:user) { FactoryBot.build(:user) }"

      line = FasterFactory::Line.new(line_with_create)
      line.replace_create_with_build!

      expect(line.content).to eq line_with_build
    end
  end
end
