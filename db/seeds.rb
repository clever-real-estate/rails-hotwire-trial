require "csv"

User.find_or_create_by!(email: "test@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
end

Photo.destroy_all

CSV.foreach(Rails.root.join("db/photos.csv"), headers: true) do |row|
  Photo.create!(
    title: row["alt"],
    photographer: row["photographer"],
    image_url: row["src.medium"],
    source_url: row["url"]
  )
end