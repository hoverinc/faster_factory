RSpec.describe FasterFactory::File do
  it "requires an initialization argument" do
    file = FasterFactory::File.new "path/to/file.rb"

    expect(file).to_not be_nil
  end
end
