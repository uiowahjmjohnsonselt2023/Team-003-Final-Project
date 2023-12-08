require 'rails_helper'

RSpec.describe UserVerificationMailer, type: :mailer do
  describe 'verification_email' do
    let(:user) { create(:user) }
    let(:mail) { described_class.verification_email(user).deliver_now }

    it 'renders the headers' do
      expect(mail.subject).to eq('Verify Your Account')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['verification@notebay.com']) # Set your email address
    end

    it 'renders the body with verification link' do
      expect(mail.body.encoded).to include("/verify/#{user.verification_token}")
    end
  end
end
