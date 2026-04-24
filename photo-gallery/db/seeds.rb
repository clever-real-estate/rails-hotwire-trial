require "csv"

%w[demo1@example.com demo2@example.com demo3@example.com].each do |email|
  User.find_or_create_by!(email_address: email) do |user|
    user.password = "clever123"
  end
end

CSV.foreach(Rails.root.join("db/seeds/photos.csv"), headers: true) do |row|
  Photo.find_or_create_by!(source_url: row["url"]) do |photo|
    photo.photographer = row["photographer"]
    photo.src_medium   = row["src.medium"]
    photo.alt          = row["alt"]
  end
end
