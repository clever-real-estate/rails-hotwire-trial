FactoryBot.define do
  factory :photo do
    photographer { "MyString" }
    src_medium { "MyString" }
    source_url { "MyString" }
    alt { "MyString" }
    likes_count { 1 }
  end
end
