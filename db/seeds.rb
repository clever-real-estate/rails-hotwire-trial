require "csv"

Like.destroy_all
Photo.destroy_all
User.destroy_all

User.create!(
  email: "test1@thisplateishotwire.com",
  password: "abc123",
  password_confirmation: "abc123"
)

User.create!(
  email: "test2@thisplateishotwire.com",
  password: "123abc",
  password_confirmation: "123abc"
)

puts "#{User.count} current users"

# loop through CSV and create photos
csv_path = Rails.root.join("db", "../assets/photos.csv")
CSV.foreach(csv_path, headers: true) do |row|
  Photo.create!(
    title: row["alt"],
    owner: row["photographer"],
    image_url: row["src.medium"],
    source_url: row["url"]
  )
end

puts "#{Photo.count} current photos"
