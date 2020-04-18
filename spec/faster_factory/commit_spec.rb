RSpec.describe FasterFactory::Commit do
  describe "#initialize" do
    it "requires initialization arguments: path line_number from to" do
      init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37 }
      commit = FasterFactory::Commit.new init_args

      expect(commit).not_to be nil
    end

    it "allows a 'template' initialization argument" do
      init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37, template: "Lorem ipsum" }
      commit = FasterFactory::Commit.new init_args

      expect(commit).not_to be nil
    end
  end

  describe "#content" do
    context "with no 'template' argument" do
      it "returns the template value" do
        init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37, template: "Lorem ipsum" }
        commit = FasterFactory::Commit.new init_args

        expect(commit.content).to eq "Lorem ipsum"
      end
    end

    context "with no 'template' argument" do
      it "returns a default value" do
        init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37 }
        commit = FasterFactory::Commit.new init_args

        expect(commit.content).to eq "[TCR] Replace 'create' with 'build' in path/to/file.rb:37"
      end
    end
  end
end
