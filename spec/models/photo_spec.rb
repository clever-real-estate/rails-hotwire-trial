require "rails_helper"

RSpec.describe Photo, type: :model do
  it "has many photo_likes" do
    association = described_class.reflect_on_association(:photo_likes)
    expect(association.macro).to eq(:has_many)
  end

  it "has many likers through photo_likes" do
    association = described_class.reflect_on_association(:likers)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:photo_likes)
  end
end
