RSpec.describe FasterFactory::TestFile do
  it "requires an initialization argument" do
    file = FasterFactory::TestFile.new "spec/examples/example_spec_file.rb"

    expect(file).to_not be_nil
  end

  describe "#absolute_path" do
    it "calculates its absolute file path" do
      example_spec_file = FasterFactory::TestFile.new "spec/examples/example_spec_file.rb"

      expect(example_spec_file.absolute_path).to eq "#{Dir.pwd}/spec/examples/example_spec_file.rb"
    end
  end

  describe "#path" do
    it "uses the initialization argument" do
      example_spec_file = FasterFactory::TestFile.new "spec/examples/example_spec_file.rb"

      expect(example_spec_file.path).to eq "spec/examples/example_spec_file.rb"
    end

    it "trims leading slash" do
      example_spec_file = FasterFactory::TestFile.new "/spec/examples/example_spec_file.rb"

      expect(example_spec_file.path).to eq "spec/examples/example_spec_file.rb"
    end

    it "trims leading slashes" do
      example_spec_file = FasterFactory::TestFile.new "///////spec/examples/example_spec_file.rb"

      expect(example_spec_file.path).to eq "spec/examples/example_spec_file.rb"
    end
  end

  describe "#lines" do
    it "converts a file’s contents into an array of Line objects" do
      example_spec_file = FasterFactory::TestFile.new "spec/examples/example_spec_file.rb"
      line_classes      = example_spec_file.lines.map(&:class).uniq

      expect(line_classes).to eq [FasterFactory::Line]
    end
  end
end
