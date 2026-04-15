require "csv"

Like.destroy_all
Photo.destroy_all
User.destroy_all

User.create!(
  email: "user@photogallery.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  email: "test@photogallery.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "✅ Created #{User.count} users"

csv_path = Rails.root.join("db", "photos.csv")
CSV.foreach(csv_path, headers: true) do |row|
  Photo.create!(
    title: row["alt"],
    photographer_name: row["photographer"],
    image_url: row["src.medium"],
    source_url: row["url"]
  )
end

puts "✅ Created #{Photo.count} photos"
