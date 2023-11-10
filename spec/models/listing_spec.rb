require 'rails_helper'

RSpec.describe Listing, type: :model do
  it "should belong to a user" do
    expect(Listing.new).to respond_to(:user)
  end

end