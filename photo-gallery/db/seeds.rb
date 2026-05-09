# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

# Create test user i kept getting warning about the password 'password' showing uo in a data breach so
# I just used the email as a password
User.find_or_create_by!(email: "test@example.com") { |u| u.password = "test@example.com" }

# Load photos
csv_path = Rails.root.join("..", "photos.csv")
CSV.foreach(csv_path, headers: true) do |row|
  Photo.find_or_create_by!(source_url: row["url"]) do |photo|
    photo.image_url = row["src.medium"]
    photo.photographer = row["photographer"]
    photo.alt = row["alt"]
  end
end