require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user)  { create(:user) }
  let(:photo) { create(:photo) }

  it "redirects unauthenticated POSTs to sign-in" do
    post photo_like_path(photo)

    expect(response).to redirect_to(new_session_path)
  end

  it "creates a like and responds with a Turbo Stream" do
    sign_in_as(user)

    post photo_like_path(photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }

    expect(response).to have_http_status(:ok)
    expect(response.media_type).to eq("text/vnd.turbo-stream.html")
    expect(user.likes.where(photo: photo)).to exist
    expect(photo.reload.likes_count).to eq(1)
  end

  it "destroys a like and responds with a Turbo Stream" do
    sign_in_as(user)
    create(:like, user: user, photo: photo)

    delete photo_like_path(photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }

    expect(response).to have_http_status(:ok)
    expect(response.media_type).to eq("text/vnd.turbo-stream.html")
    expect(user.likes.where(photo: photo)).not_to exist
    expect(photo.reload.likes_count).to eq(0)
  end
end
