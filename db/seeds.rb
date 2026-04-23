require "csv"

# Seed users
User.find_or_create_by!(email: "user@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
end

# Seed photos from CSV
csv_path = Rails.root.join("db", "photos.csv")
CSV.foreach(csv_path, headers: true) do |row|
  Photo.find_or_create_by!(pexels_id: row["id"].to_i) do |photo|
    photo.url = row["url"]
    photo.photographer = row["photographer"]
    photo.photographer_url = row["photographer_url"]
    photo.image_url = row["src.medium"]
    photo.alt = row["alt"]
  end
end

puts "Seeded #{User.count} user(s) and #{Photo.count} photo(s)."
