require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "GET /photos requires authentication" do
    get photos_path
    assert_redirected_to sign_in_path
  end

  test "signed-in user sees all photo cards" do
    post sign_in_path, params: { email: "demo@clever.example", password: "password" }
    get photos_path
    assert_response :success
    Photo.all.each do |photo|
      assert_select "article##{ActionView::RecordIdentifier.dom_id(photo)}"
    end
  end

  test "signed-in user with a like sees aria-pressed=true on that photo" do
    Like.create!(user: users(:demo), photo: photos(:lake))
    post sign_in_path, params: { email: "demo@clever.example", password: "password" }
    get photos_path
    assert_response :success
    assert_select "##{ActionView::RecordIdentifier.dom_id(photos(:lake), :like_button)} .like[aria-pressed='true']"
  end
end
