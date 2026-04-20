FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    name { "Test User" }
    password { "password123" }

    after(:build) { |u| u.password_confirmation = u.password }
  end
end
