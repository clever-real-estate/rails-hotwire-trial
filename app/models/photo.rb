class Photo < ApplicationRecord
  include Likeable

  validates :photographer_name, :alt, presence: true
  validates :original_url, :medium_url, format: { with: URI.regexp(%w[http https]) }
end
