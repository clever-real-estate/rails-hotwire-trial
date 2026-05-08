require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'validations' do
    it 'does not allow a user to like the same photo more than once' do
      user = User.create!(
        email: 'test@example.com',
        password: 'password123'
      )

      photo = Photo.create!(
        photographer: 'Test Photographer',
        source_url: 'https://example.com',
        image_url: 'https://example.com/photo.jpg'
      )

      Like.create!(user: user, photo: photo)

      duplicate_like = Like.new(user: user, photo: photo)

      expect(duplicate_like).not_to be_valid
      expect(duplicate_like.errors[:user_id]).to include('has already been taken')
    end
  end
end
