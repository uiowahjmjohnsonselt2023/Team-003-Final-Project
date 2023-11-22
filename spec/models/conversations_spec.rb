require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it "is valid with valid attributes" do
    user1 = create(:user)
    user2 = create(:user)
    conversation = Conversation.new(sender_id: user1.id, recipient_id: user2.id)

    expect(conversation).to be_valid
  end

  it "is not valid without a sender" do
    conversation = Conversation.new(sender_id: nil, recipient_id: create(:user).id)

    expect(conversation).not_to be_valid
  end

  it "is not valid without a recipient" do
    conversation = Conversation.new(sender_id: create(:user).id, recipient_id: nil)

    expect(conversation).not_to be_valid
  end
end
