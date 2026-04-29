FactoryBot.define do
  factory :photo do
    image_url { "MyString" }
    photographer_name { "MyString" }
    photographer_url { "MyString" }
    alt_text { "MyText" }
    likes_count { 1 }
  end
end
