require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  describe "GET #follower" do
    it "returns http success" do
      get :follower
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #followed" do
    it "returns http success" do
      get :followed
      expect(response).to have_http_status(:success)
    end
  end
end
