RSpec.describe FasterFactory::CommitMessage do
  it "requires 'path' and 'line_number' initialization arguments" do
    commit_message = FasterFactory::CommitMessage.new path: "path/to/file.rb", line_number: 37
    expect(commit_message).not_to be nil
  end
end
