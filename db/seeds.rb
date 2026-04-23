# Create test users
User.create!([
  { 
    email: 'smith1@example.com', 
    password: "password123", 
    password_confirmation: "password123"
  },
  { 
    email: 'smith2@example.com', 
    password: "password123", 
    password_confirmation: "password123"
  }
])
puts "Test users created."

# Read photos.csv and create test photos
rows = CSV.read(Rails.root.join("photos.csv"), headers: true)
photos_attributes = rows.map do |row|
  {
    photographer_name: row["photographer"],
    original_url: row["url"],
    medium_url: row["src.medium"],
    alt: row["alt"]
  }
end
Photo.create!(photos_attributes)
puts "Test photos created."