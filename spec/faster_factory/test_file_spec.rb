RSpec.describe FasterFactory::File do
  it "requires an initialization argument" do
    file = FasterFactory::TestFile.new "path/to/file.rb"

    expect(file).to_not be_nil
  end

  describe "#path" do
    it "calculates its absolute file path" do
      example_spec_file = FasterFactory::TestFile.new "spec/examples/example_spec_file.rb"

      expect(example_spec_file.path).to eq "spec/examples/example_spec_file.rb"
    end
  end
end
