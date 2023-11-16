require 'rails_helper'

describe "GET /show" do
  it "returns http success" do
    tracking = create(:tracking)
    get tracking_path(tracking)
    expect(response).to have_http_status(:success)
  end
end
