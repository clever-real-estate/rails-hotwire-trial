require "csv"

CSV_PATH = Rails.root.join("..", "photos.csv").exist? ?
             Rails.root.join("..", "photos.csv") :
             Rails.root.join("photos.csv")

# --- Users ---
[
  { email: "demo@clever.example",   name: "Demo User",   password: "password" },
  { email: "second@clever.example", name: "Second User", password: "password" }
].each do |attrs|
  user = User.find_or_initialize_by(email: attrs[:email])
  user.assign_attributes(name: attrs[:name], password: attrs[:password])
  user.save!
end

# --- Photos ---
unless CSV_PATH.exist?
  abort "Could not find photos.csv at #{CSV_PATH}"
end

CSV.foreach(CSV_PATH, headers: true) do |row|
  photo = Photo.find_or_initialize_by(pexels_id: row["id"].to_i)
  photo.assign_attributes(
    width:            row["width"].to_i,
    height:           row["height"].to_i,
    url:              row["url"],
    photographer:     row["photographer"],
    photographer_url: row["photographer_url"],
    photographer_id:  row["photographer_id"].to_i,
    avg_color:        row["avg_color"],
    src_original:     row["src.original"],
    src_large2x:      row["src.large2x"],
    src_large:        row["src.large"],
    src_medium:       row["src.medium"],
    src_small:        row["src.small"],
    src_portrait:     row["src.portrait"],
    src_landscape:    row["src.landscape"],
    src_tiny:         row["src.tiny"],
    alt:              row["alt"]
  )
  photo.save!
end

puts "Seeded #{User.count} user(s) and #{Photo.count} photo(s)."
