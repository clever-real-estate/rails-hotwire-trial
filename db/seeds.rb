require 'csv'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


users = [
  ["markjohnson@gmail.com", "password"],
  ["danrubio@gmail.com", "password"],
  ["evajimenez@gmail.com", "password"]
]

users.each do |email, password|
  User.find_or_create_by!(email: email) do |user|
    user.password = password
  end
end

csv_path = Rails.root.join("db/photos.csv")

CSV.foreach(csv_path, headers: true) do |row|
  Photo.find_or_create_by!(id: row["id"]) do |photo|
    photo.photographer = row["photographer"]
    photo.image_url = row["src.medium"]
    photo.source_url = row["url"]
    photo.alt = row["alt"]
  end
end