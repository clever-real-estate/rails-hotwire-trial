require "rails_helper"

RSpec.describe Photo, type: :model do
  let(:user) { create(:user) }
  let(:photo) { create(:photo) }

  it "increments the likes count by 1" do
    PhotoLike.destroy_all
    PhotoLike.create(user: user, photo: photo)
    expect(photo.reload.photo_likes_count).to eq(1)
  end

  it "resets the likes count to 0" do
    PhotoLike.destroy_all
    expect(photo.reload.photo_likes_count).to eq(0)
  end

  it "shows the user HAS NOT liked the photo" do
    PhotoLike.destroy_all
    expect(photo.liked_by?(user)).to be_falsey
  end

  it "shows the user HAS liked the photo" do
    photo.photo_likes.create!(user: user)
    expect(photo.liked_by?(user)).to be_truthy
  end
end