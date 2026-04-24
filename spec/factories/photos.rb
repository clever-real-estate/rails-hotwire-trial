FactoryBot.define do
  factory :photo do
    sequence(:external_id) { |n| "ext-#{n}" }
    photographer     { "Ansel Adams" }
    photographer_url { "https://www.pexels.com/@ansel" }
    src_medium       { "https://images.pexels.com/photos/1/medium.jpg" }
    source_url       { "https://www.pexels.com/photo/1/" }
    alt              { "A beautiful photo" }
  end
end
