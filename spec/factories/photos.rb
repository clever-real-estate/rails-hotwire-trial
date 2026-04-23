FactoryBot.define do
  factory :photo do
    photographer_name { "Test Photographer" }
    original_url { "https://example.com/photo-original.jpg" }
    medium_url { "https://example.com/photo-medium.jpg" }
    alt { "Test Photo" }
  end
end
