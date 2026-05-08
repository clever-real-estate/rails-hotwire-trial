require 'rails_helper'

RSpec.describe 'Photo likes', type: :system do
  it 'allows a user to like and unlike a photo' do
    user = User.create!(
      email: 'test@example.com',
      password: 'password123'
    )

    photo = Photo.create!(
      photographer: 'Test Photographerindex',
      source_url: 'https://example.com',
      image_url: 'https://example.com/photo.jpg'
    )

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'

    click_button 'Sign in'

    expect(page).to have_content('Test Photographer')
    expect(photo.likes.count).to eq(0)

    click_button class: 'like-button'

    expect(page).to have_css('.star-fill', visible: true)
    expect(photo.likes.reload.count).to eq(1)

    click_button class: 'like-button'

    expect(page).to have_css('.star-line', visible: true)
    expect(photo.likes.reload.count).to eq(0)
  end
end
