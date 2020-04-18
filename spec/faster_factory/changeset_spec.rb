RSpec.describe FasterFactory::Changeset do
  describe "#initialize" do
    it "requires initialization arguments: path line_number from to" do
      init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37 }
      changeset = FasterFactory::Changeset.new init_args

      expect(changeset).not_to be nil
    end

    it "allows a 'template' initialization argument" do
      init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37, template: "Lorem ipsum" }
      changeset = FasterFactory::Changeset.new init_args

      expect(changeset).not_to be nil
    end
  end

  describe "#message" do
    context "with no 'template' argument" do
      it "returns the template value" do
        init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37, template: "Lorem ipsum" }
        changeset = FasterFactory::Changeset.new init_args

        expect(changeset.message).to eq "Lorem ipsum"
      end
    end

    context "with no 'template' argument" do
      it "returns a default value" do
        init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37 }
        changeset = FasterFactory::Changeset.new init_args

        expect(changeset.message).to eq "[TCR] Replace 'create' with 'build' in path/to/file.rb:37"
      end
    end
  end
end
