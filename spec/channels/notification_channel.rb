# spec/channels/notification_channel_spec.rb
require 'rails_helper'

RSpec.describe NotificationChannel, type: :channel do
  let(:user) { create(:user) }

  before do
    stub_connection current_user: user
    subscribe
  end

  it 'broadcasts notifications' do
    expect {
      NotificationChannel.broadcast_to(
        user,
        title: 'New Message',
        content: 'You have a new message'
      )
    }.to have_broadcasted_to(user).with(hash_including(title: 'New Message'))
  end
end
