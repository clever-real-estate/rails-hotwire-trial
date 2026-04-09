require "rails_helper"

RSpec.describe Photo, type: :model do
  let(:photo) { photos(:one) }
  let(:user) { users(:one) }

  it "tracks the number of likes" do
    Photo.reset_counters(photo.id, :photo_likes)
    expect(photo.reload.like_count).to eq(1) # one like initially created in the photo_likes.yml fixture
    PhotoLike.destroy_all
    expect(photo.reload.like_count).to eq(0)
  end

  it "has a liked_by? method" do
    PhotoLike.destroy_all
    expect(photo.liked_by?(user)).to be_falsey
    photo.photo_likes.create!(user: user)
    expect(photo.liked_by?(user)).to be_truthy
  end
end
