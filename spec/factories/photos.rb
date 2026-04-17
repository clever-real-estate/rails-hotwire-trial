FactoryBot.define do
  factory :photo do
    title { "Sample Photo" }
    image_url { "https://example.com/photo.jpg" }
    owner { "Test Owner" }
    source_url { "https://example.com" }
  end
end
