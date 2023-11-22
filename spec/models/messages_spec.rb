require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:message)).to be_valid
  end

  it 'is not valid without a body' do
    expect(build(:message, body: nil)).not_to be_valid
  end
end