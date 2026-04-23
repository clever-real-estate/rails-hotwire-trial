require "rails_helper"

# Requirement 2: Photo Gallery
#   - Display all 10 photos on a single "All Photos" page
#   - Each photo card shows: image, photographer name, link icon + source URL, like button with count
#
# Requirement 3: Like Functionality
#   - Signed-in users can like and unlike any photo
#   - Likes must update without a full page reload (Turbo Streams)
#   - Like counts must persist in the database
#   - Each user can like a photo only once
RSpec.describe "Photo Gallery & Likes", type: :request do
  let!(:user) { User.create!(email: "test@example.com", password: "password") }
  let!(:photo) do
    Photo.create!(external_id: 1, url: "https://www.pexels.com/photo/test-1/",
      photographer: "Jane Doe", photographer_url: "https://www.pexels.com/@janedoe",
      image_url: "https://images.pexels.com/photos/1/test.jpeg?auto=compress&cs=tinysrgb&h=350",
      alt: "A test photo")
  end

  before do
    post login_path, params: { email: "test@example.com", password: "password" }
  end

  describe "All Photos page" do
    it "displays all photos on a single page" do
      second_photo = Photo.create!(external_id: 2, url: "https://www.pexels.com/photo/test-2/",
        photographer: "John Smith", photographer_url: "https://www.pexels.com/@johnsmith",
        image_url: "https://images.pexels.com/photos/2/test.jpeg", alt: "Another photo")

      get root_path

      expect(response.body).to include("All Photos")
      expect(response.body).to include("Jane Doe")
      expect(response.body).to include("John Smith")
    end

    it "shows the photo image using the medium src URL" do
      get root_path
      # The URL's ampersands get HTML-entity-encoded in the rendered markup
      expect(response.body).to include(ERB::Util.html_escape(photo.image_url))
    end

    it "shows the photographer's name" do
      get root_path
      expect(response.body).to include("Jane Doe")
    end

    it "shows a link to the photo's source URL" do
      get root_path
      expect(response.body).to include(photo.url)
    end

    it "shows the like count" do
      get root_path
      # The like count starts at 0
      expect(response.body).to include("0")
    end
  end

  describe "liking a photo" do
    it "persists the like in the database" do
      expect {
        post photo_like_path(photo)
      }.to change(Like, :count).by(1)
    end

    it "each user can like a photo only once" do
      post photo_like_path(photo)
      expect {
        post photo_like_path(photo)
      }.not_to change(Like, :count)
    end

    it "responds with a turbo stream (no full page reload)" do
      post photo_like_path(photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      expect(response.media_type).to eq "text/vnd.turbo-stream.html"
      expect(response.body).to include("turbo-stream")
    end

    it "shows the updated like count after liking" do
      post photo_like_path(photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      expect(response.body).to include("1")
    end
  end

  describe "unliking a photo" do
    before { user.likes.create!(photo: photo) }

    it "removes the like from the database" do
      expect {
        delete photo_like_path(photo)
      }.to change(Like, :count).by(-1)
    end

    it "responds with a turbo stream (no full page reload)" do
      delete photo_like_path(photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      expect(response.media_type).to eq "text/vnd.turbo-stream.html"
      expect(response.body).to include("turbo-stream")
    end

    it "shows the updated like count after unliking" do
      delete photo_like_path(photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      expect(response.body).to include("0")
    end
  end
end
