require 'rails_helper'

RSpec.describe "Trackings", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get tracking_show_path
      expect(response).to have_http_status(:success)
    end
  end
end
