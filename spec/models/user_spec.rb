require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(username: "john_doe", email: "john@example.com", password: "password123")
    expect(user).to be_valid
    expect(user.verified).to be false
  end
  describe '#verify_account' do
    let(:user_valid_token) { create(:user, verification_token: 'valid_token') }
    let(:user_invalid_token) { create(:user, verification_token: 'valid_token') }
    let(:user_verified) { create(:user, verification_token: nil, verified: true) }

    it 'verifies the user account with a valid token' do
      expect(user_valid_token.verify_account('valid_token')).to be true
      expect(user_valid_token.reload.verified).to be true
      expect(user_valid_token.reload.verification_token).to be_nil
    end

    it 'does not verify the user account with an invalid token' do
      expect(user_invalid_token.verify_account('invalid_token')).to be false
      expect(user_invalid_token.reload.verified).to be false
      expect(user_invalid_token.reload.verification_token).not_to be_nil
    end

    it 'does not verify an already verified user account' do
      expect(user_verified.verify_account('valid_token')).to be false
    end
  end
end