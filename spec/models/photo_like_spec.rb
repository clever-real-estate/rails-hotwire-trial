require "rails_helper"

RSpec.describe PhotoLike, type: :model do
  let(:user) { users(:one) }
  let(:photo) { photos(:one) }
  let(:photo_like) { photo_likes(:one) }

  it "belongs to a user" do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it "belongs to a photo" do
    association = described_class.reflect_on_association(:photo)
    expect(association.macro).to eq(:belongs_to)
  end

  it "is unique for a given user and photo" do
    duplicate_photo_like = PhotoLike.new(user: user, photo: photo)
    expect(duplicate_photo_like).not_to be_valid
    expect(duplicate_photo_like.errors.full_messages).to include("User has already liked this photo")
  end
end
