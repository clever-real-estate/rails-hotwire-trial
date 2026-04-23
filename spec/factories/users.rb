FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" } # ensure factory users have unique emails
    password { "password123" }
  end
end
