# FactoryBot and FactoryGirl are used in examples to help ensure
# that this works for older codebases that haven’t upgraded to FactoryBot too

RSpec.describe FasterFactory::Line do
  it "requires an initialization argument" do
    line = FasterFactory::Line.new "asdf"
    expect(line).not_to be nil
  end

  describe "#original_content" do
    it "sets #original_content from the initialization argument" do
      line_content = "let(:user) { FactoryGirl.build(:user) }"
      line         = FasterFactory::Line.new line_content

      expect(line.original_content).to eq line_content
    end
  end

  describe "#content" do
    it "sets #content from the initialization argument" do
      line_content = "let(:user) { FactoryGirl.build(:user) }"
      line         = FasterFactory::Line.new line_content

      expect(line.content).to eq line_content
    end
  end

  describe "#build_present?" do
    it "knows that '.build' is in its #content" do
      line_with_build = "let(:user) { FactoryGirl.build(:user) }"
      line            = FasterFactory::Line.new line_with_build

      expect(line.build_present?).to eq true
    end

    it "knows that '.build' is not in its #content" do
      line_without_build = "let(:user) { FactoryGirl.create(:user) }"
      line               = FasterFactory::Line.new line_without_build

      expect(line.build_present?).to eq false
    end
  end

  describe "#build_stubbed_present?" do
    it "knows that '.build_stubbed' is in its #content" do
      line_with_build_stubbed = "let(:user) { FactoryGirl.build_stubbed(:user) }"
      line                    = FasterFactory::Line.new(line_with_build_stubbed)

      expect(line.build_stubbed_present?).to eq true
    end

    it "knows that '.build_stubbed' is not in its #content" do
      line_without_build_stubbed = "let(:user) { FactoryGirl.create(:user) }"
      line                       = FasterFactory::Line.new line_without_build_stubbed

      expect(line.build_stubbed_present?).to eq false
    end
  end

  describe "#create_present?" do
    it "knows that '.create' is in its #content" do
      line_with_create = "let(:user) { FactoryBot.create(:user) }"
      line             = FasterFactory::Line.new line_with_create

      expect(line.create_present?).to eq true
    end

    it "knows that '.create' is not in its #content" do
      line_without_create = "let(:user) { FactoryBot.build(:user) }"
      line                = FasterFactory::Line.new line_without_create

      expect(line.create_present?).to eq false
    end
  end

  describe "#replace_create_with_build!" do
    it "replaces '.create' with '.build' in #content" do
      line_with_create = "let(:user) { FactoryBot.create(:user) }"
      line_with_build  = "let(:user) { FactoryBot.build(:user) }"

      line = FasterFactory::Line.new line_with_create
      line.replace_create_with_build!

      expect(line.content).to eq line_with_build
    end
  end

  describe "#replace_build_with_build_stubbed!" do
    it "replaces '.build' with '.build_stubbed' in #content" do
      line_with_build         = "let(:user) { FactoryBot.build(:user) }"
      line_with_build_stubbed = "let(:user) { FactoryBot.build_stubbed(:user) }"

      line = FasterFactory::Line.new line_with_build
      line.replace_build_with_build_stubbed!

      expect(line.content).to eq line_with_build_stubbed
    end
  end
end
