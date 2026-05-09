require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "password") }

  let(:photo) do
    Photo.create!(
      image_url: "http://example.com/photo.jpg",
      photographer: "Test",
      source_url: "http://example.com",
      alt: "Test photo"
    )
  end

  describe "authentication" do
    it "requires login to like a photo" do
      post photo_like_path(photo)
      expect(response).to redirect_to(sign_in_path)
    end
  end

  context "when logged in" do
    before do
      post sign_in_path, params: { email: user.email, password: "password" }
    end

    describe "POST /photos/:photo_id/like" do
      it "creates a like" do
        expect {
          post photo_like_path(photo)
        }.to change { Like.count }.by(1)
      end

      it "does not allow duplicate likes" do
        post photo_like_path(photo)

        expect {
          post photo_like_path(photo)
        }.not_to change { Like.count }
      end

      it "responds with turbo stream" do
        post photo_like_path(photo)

        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end
    end

    describe "DELETE /photos/:photo_id/like" do
      it "removes a like" do
        Like.create!(user: user, photo: photo)

        expect {
          delete photo_like_path(photo)
        }.to change { Like.count }.by(-1)
      end
    end
  end
end