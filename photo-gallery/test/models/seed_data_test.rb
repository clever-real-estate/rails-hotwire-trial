require "test_helper"
require "stringio"

class SeedDataTest < ActiveSupport::TestCase
  test "seeds demo users and ten photos from csv" do
    original_stdout = $stdout
    begin
      $stdout = StringIO.new
      load Rails.root.join("db/seeds.rb")
    ensure
      $stdout = original_stdout
    end

    assert_equal 10, Photo.count
    assert_equal 2, User.count
    assert User.find_by(username: "demo").authenticate("password123")
    assert User.find_by(username: "test").authenticate("password456")
  end
end
