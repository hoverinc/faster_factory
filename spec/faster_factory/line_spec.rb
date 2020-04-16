RSpec.describe FasterFactory::Line do
  it "requires an initialization argument" do
    expect(FasterFactory::Line.new("asdf")).not_to be nil
  end
end
