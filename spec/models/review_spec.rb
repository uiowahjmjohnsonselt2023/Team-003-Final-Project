require 'rails_helper'

RSpec.describe Review, type: :model do
  it "should belong to a reviewer" do
    expect(Review.new).to respond_to(:reviewer)
  end

  it "should belong to a reviewee" do
    expect(Review.new).to respond_to(:reviewee)
  end
end