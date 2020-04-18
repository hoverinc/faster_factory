RSpec.describe FasterFactory::CommitMessage do
  describe "#initialize" do
    it "requires initialization arguments: path line_number from to" do
      init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37 }
      commit_message = FasterFactory::CommitMessage.new init_args

      expect(commit_message).not_to be nil
    end

    it "allows a 'template' initialization argument" do
      init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37, template: "Lorem ipsum" }
      commit_message = FasterFactory::CommitMessage.new init_args

      expect(commit_message).not_to be nil
    end
  end

  describe "#content" do
    context "with no 'template' argument" do
      it "returns a default value  asdfasdf" do
        init_args = { from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37 }
        commit_message = FasterFactory::CommitMessage.new init_args

        expect(commit_message.content).to eq "[TCR] Replace 'create' with 'build' in path/to/file.rb:37"
      end
    end
  end
end
