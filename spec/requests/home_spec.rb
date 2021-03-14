require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it "returns http success for [url]/home/index" do
      get "/home/index"
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET /home" do
    it "returns http success for [url]/home" do
      get "/home"
      expect(response).to have_http_status(:success)
    end
  end
end
