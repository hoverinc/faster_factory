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
end
