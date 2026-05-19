# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'csv'

# Clear existing data
Like.delete_all
Photo.delete_all
User.delete_all

# Create test users
user1 = User.create!(username: 'demo', password: 'password123')
user2 = User.create!(username: 'test', password: 'password456')

puts "Created users: #{user1.username}, #{user2.username}"

# Seed photos from CSV
csv_file = Rails.root.join('photos.csv')
CSV.foreach(csv_file, headers: true) do |row|
  Photo.create!(
    id: row['id'].to_i,
    width: row['width'].to_i,
    height: row['height'].to_i,
    url: row['url'],
    photographer: row['photographer'],
    photographer_url: row['photographer_url'],
    photographer_id: row['photographer_id'].to_i,
    avg_color: row['avg_color'],
    src_medium: row['src.medium'],
    alt: row['alt']
  )
end

puts "Seeded #{Photo.count} photos"
puts "Database seeding complete!"
