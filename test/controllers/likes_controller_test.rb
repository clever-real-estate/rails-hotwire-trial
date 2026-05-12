require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    post sign_in_path, params: { email: "demo@clever.example", password: "password" }
  end

  test "POST creates a like and responds with a turbo stream" do
    assert_difference -> { Like.count }, +1 do
      post photo_like_path(photos(:lake)),
           headers: { "Accept" => "text/vnd.turbo-stream.html" }
    end

    assert_response :success
    assert_equal "text/vnd.turbo-stream.html; charset=utf-8", @response.media_type + "; charset=utf-8"
    assert_match /turbo-stream action="replace"/, @response.body
    assert_match /like_button_photo_#{photos(:lake).id}/, @response.body
    assert_match /aria-pressed="true"/, @response.body
  end

  test "POST is idempotent (double click does not raise)" do
    post photo_like_path(photos(:lake)), headers: { "Accept" => "text/vnd.turbo-stream.html" }
    assert_response :success
    assert_no_difference -> { Like.count } do
      post photo_like_path(photos(:lake)), headers: { "Accept" => "text/vnd.turbo-stream.html" }
    end
    assert_response :success
  end

  test "DELETE removes the like" do
    Like.create!(user: users(:demo), photo: photos(:lake))
    assert_difference -> { Like.count }, -1 do
      delete photo_like_path(photos(:lake)),
             headers: { "Accept" => "text/vnd.turbo-stream.html" }
    end
    assert_response :success
    assert_match /aria-pressed="false"/, @response.body
  end

  test "unauthenticated like is redirected" do
    delete sign_out_path
    post photo_like_path(photos(:lake))
    assert_redirected_to sign_in_path
  end
end
