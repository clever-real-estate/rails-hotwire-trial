# spec/requests/likes_spec.rb
require "rails_helper"

RSpec.describe "Likes", type: :request do
  before { sign_in users(:user_one) }

  describe "POST /photos/:photo_id/like" do
    it "creates a like" do
      expect {
        post photo_like_path(photos(:photo_two)),
          headers: { "Accept" => "text/vnd.turbo-stream.html" }
      }.to change(Like, :count).by(1)
    end

    it "does not allow liking the same photo twice" do
      expect {
        post photo_like_path(photos(:photo_one)),
          headers: { "Accept" => "text/vnd.turbo-stream.html" }
      }.not_to change(Like, :count)
    end
  end

  describe "DELETE /photos/:photo_id/like" do
    it "destroys the like" do
      expect {
        delete photo_like_path(photos(:photo_one)),
          headers: { "Accept" => "text/vnd.turbo-stream.html" }
      }.to change(Like, :count).by(-1)
    end
  end
end
