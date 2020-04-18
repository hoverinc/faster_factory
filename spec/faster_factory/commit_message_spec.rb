RSpec.describe FasterFactory::CommitMessage do
  it "requires an initialization argument" do
    commit_message = FasterFactory::CommitMessage.new "asdf"
    expect(commit_message).not_to be nil
  end
end
