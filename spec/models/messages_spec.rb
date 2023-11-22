require 'rails_helper'

RSpec.describe Message, type: :model do
  it "is valid with valid attributes" do
    conversation = create(:conversation)
    message = Message.new(body: "Hello", conversation: conversation, user: conversation.sender)

    expect(message).to be_valid
  end

  it "is not valid without a body" do
    message = Message.new(body: nil)

    expect(message).not_to be_valid
  end
end
