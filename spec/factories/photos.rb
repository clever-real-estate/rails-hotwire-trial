FactoryBot.define do
  factory :photo do
    image_url { "https://example.com/image.jpg" }
    source_url { "https://example.com/source" }
    photographer_name { "A Photographer" }
    photographer_url { "https://example.com/photographer" }
    alt_text { "A test photo" }
  end
end
