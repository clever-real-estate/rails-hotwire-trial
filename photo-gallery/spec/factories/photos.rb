FactoryBot.define do
  factory :photo do
    sequence(:photographer) { |n| "Photographer #{n}" }
    sequence(:source_url)   { |n| "https://example.com/photo/#{n}" }
    src_medium              { "https://example.com/image.jpg" }
    alt                     { "A test photo" }
  end
end
