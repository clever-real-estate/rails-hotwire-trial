require "csv"

rows = CSV.read(Rails.root.join("photos.csv"), headers: true)
now = Time.current

attributes = rows.map do |row|
  {
    external_id: row["id"].to_i,
    width: row["width"].to_i,
    height: row["height"].to_i,
    url: row["url"],
    photographer: row["photographer"],
    photographer_url: row["photographer_url"],
    photographer_id: row["photographer_id"].to_i,
    avg_color: row["avg_color"],
    src_original: row["src.original"],
    src_large2x: row["src.large2x"],
    src_large: row["src.large"],
    src_medium: row["src.medium"],
    src_small: row["src.small"],
    src_portrait: row["src.portrait"],
    src_landscape: row["src.landscape"],
    src_tiny: row["src.tiny"],
    alt: row["alt"],
    created_at: now,
    updated_at: now
  }
end

Photo.upsert_all(attributes, unique_by: :index_photos_on_external_id) if attributes.any?

User.create!(username: "test_user", password: "password")
