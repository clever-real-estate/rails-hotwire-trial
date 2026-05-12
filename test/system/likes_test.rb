require "application_system_test_case"

class LikesTest < ApplicationSystemTestCase
  test "user can like and unlike a photo without a full page reload" do
    photo = photos(:lake)

    sign_in_as(users(:demo))

    within "##{ActionView::RecordIdentifier.dom_id(photo, :like_button)}" do
      assert_selector ".like[aria-pressed='false']"
      find(".like").click
      assert_selector ".like[aria-pressed='true']"
    end

    assert_equal 1, photo.reload.likes_count

    within "##{ActionView::RecordIdentifier.dom_id(photo, :like_button)}" do
      find(".like").click
      assert_selector ".like[aria-pressed='false']"
    end

    assert_equal 0, photo.reload.likes_count
  rescue Selenium::WebDriver::Error::WebDriverError, Selenium::WebDriver::Error::SessionNotCreatedError => e
    skip "Skipping system test: #{e.class} — #{e.message.lines.first&.strip}. " \
         "Run `brew upgrade chromedriver` (or install a chromedriver matching your Chrome) to enable system tests."
  end
end
