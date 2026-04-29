require 'csv'

Photo.delete_all

CSV.foreach(Rails.root.join("photos.csv"), headers: true) do |row|
  Photo.create!(
    image_url: row["src.medium"],
    source_url: row["url"],
    photographer_name: row["photographer"],
    photographer_url: row["photographer_url"],
    alt_text: row["alt"],
  )
end
puts "Seeded #{Photo.count} photos"

user = User.where(email: "grace@test.com").first_or_initialize
user.update!(password: "test1234")

user = User.where(email: "rocky@test.com").first_or_initialize
user.update!(password: "test1234")

user = User.where(email: "artemis@test.com").first_or_initialize
user.update!(password: "test1234")