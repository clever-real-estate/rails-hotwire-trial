require "application_system_test_case"

class PhotoGalleryTest < ApplicationSystemTestCase
  setup do
    @user = User.create(username: "testuser", password: "password123")
    @photo1 = Photo.create(id: 1, url: "http://example.com/1", photographer: "Photographer One", src_medium: "http://example.com/img1.jpg", alt: "Photo 1")
    @photo2 = Photo.create(id: 2, url: "http://example.com/2", photographer: "Photographer Two", src_medium: "http://example.com/img2.jpg", alt: "Photo 2")
  end

  test "user can log in and view photo gallery" do
    visit login_path
    
    # Check login form is displayed
    assert_text "Photo Gallery"
    assert_text "Sign in to browse"
    
    # Sign in
    fill_in "Username", with: "testuser"
    fill_in "Password", with: "password123"
    click_button "Sign In"
    
    # Should be redirected to gallery
    assert_current_path photos_path
    assert_text "All Photos"
    assert_text "Welcome, testuser!"
  end

  test "photo gallery displays all photos" do
    visit login_path
    fill_in "Username", with: "testuser"
    fill_in "Password", with: "password123"
    click_button "Sign In"
    
    # Check photos are displayed
    assert_text "All Photos"
    assert_text "Photographer One"
    assert_text "Photographer Two"
    assert_selector ".photo-card", count: 2
    
    # Check photos have like buttons
    assert_selector ".like-button", count: 2, visible: :all
    assert_selector ".like-count", count: 2, visible: :all
  end

  test "user can like a photo" do
    visit login_path
    fill_in "Username", with: "testuser"
    fill_in "Password", with: "password123"
    click_button "Sign In"
    
    # Find and click like button for first photo
    within "#photo_1_like" do
      click_button "Like"
    end
    assert_selector "#photo_1_like .like-button.liked", visible: :all
    assert_selector "#photo_1_like .like-count", text: "1", visible: :all
    
    # Check that like was created
    assert_equal 1, @photo1.reload.likes.count
  end

  test "user can unlike a photo" do
    # Pre-like the photo
    @user.likes.create(photo: @photo1)
    
    visit login_path
    fill_in "Username", with: "testuser"
    fill_in "Password", with: "password123"
    click_button "Sign In"
    
    # Click to unlike
    within "#photo_1_like" do
      click_button "Unlike"
    end
    assert_no_selector "#photo_1_like .like-button.liked", visible: :all
    assert_selector "#photo_1_like .like-count", text: "0", visible: :all
    
    # Check that like was destroyed
    assert_equal 0, @photo1.reload.likes.count
  end

  test "like count displays correctly" do
    # Create some likes
    @user.likes.create(photo: @photo1)
    user2 = User.create(username: "user2", password: "pass")
    user2.likes.create(photo: @photo1)
    
    visit login_path
    fill_in "Username", with: "testuser"
    fill_in "Password", with: "password123"
    click_button "Sign In"
    
    # Check like count is displayed
    within find(".photo-card", text: "Photographer One") do
      assert_text "2"
    end
  end

  test "user can log out" do
    visit login_path
    fill_in "Username", with: "testuser"
    fill_in "Password", with: "password123"
    click_button "Sign In"
    
    # Click logout
    click_button "Logout"
    
    # Should be redirected to login
    assert_current_path login_path
  end

  test "unauthenticated user cannot access gallery" do
    visit photos_path
    assert_current_path login_path
  end

  test "invalid credentials show error message" do
    visit login_path
    fill_in "Username", with: "testuser"
    fill_in "Password", with: "wrongpass"
    click_button "Sign In"
    
    assert_text "Invalid username or password"
  end

  test "demo credentials are displayed" do
    visit login_path
    assert_text "Demo Credentials"
    assert_text "demo"
    assert_text "password123"
  end
end
