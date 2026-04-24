class Photo < ApplicationRecord
  validates :photographer, presence: true
  validates :image_url, presence: true
  validates :source_url, presence: true
  validates :alt, presence: true
end