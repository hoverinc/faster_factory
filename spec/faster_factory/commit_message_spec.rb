RSpec.describe FasterFactory::CommitMessage do
  describe "#initialize" do
    it "requires initialization arguments: path line_number from to" do
      commit_message = FasterFactory::CommitMessage.new from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37
      expect(commit_message).not_to be nil
    end

    it "requires 'path' and 'line_number' initialization arguments" do
      commit_message = FasterFactory::CommitMessage.new from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37
      expect(commit_message).not_to be nil
    end

    it "allows a 'template' initialization argument" do
      commit_message = FasterFactory::CommitMessage.new from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37, template: "Lorem ipsum"
      expect(commit_message).not_to be nil
    end
  end

  describe "#content" do
    context "with no 'template' argument" do
      it "returns a default value" do
        commit_message = FasterFactory::CommitMessage.new from: 'create', to: 'build', path: "path/to/file.rb", line_number: 37
        expect(commit_message.content).not_to be "[TCR] Replace .build with .build_stubbed in path/to/file.rb:37"
      end
    end
  end
end
