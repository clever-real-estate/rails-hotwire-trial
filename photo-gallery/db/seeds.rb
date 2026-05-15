require "csv"

User.destroy_all
Photo.destroy_all
Like.destroy_all

User.create!(email: "demo@example.com", password: "password")

CSV.foreach(Rails.root.join("photos.csv"), headers: true) do |row|
  Photo.create!(
    title:        row["alt"],
    photographer: row["photographer"],
    src_medium:   row["src.medium"],
    source_url:   row["url"],
    likes_count:  0
  )
end

puts "Seeded #{User.count} user(s) and #{Photo.count} photos."