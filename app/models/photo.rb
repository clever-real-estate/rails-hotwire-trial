class Photo < ApplicationRecord
  has_many :likes
  validates :photographer, presence: true
  validates :image_url, presence: true
  validates :source_url, presence: true
  validates :alt, presence: true
end