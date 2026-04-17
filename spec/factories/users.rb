FactoryBot.define do
  factory :user do
    email { "user#{rand(1..10000)}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
