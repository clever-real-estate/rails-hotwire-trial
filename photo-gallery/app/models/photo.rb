class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy

  validates :photographer, :src_medium, :source_url, presence: true
end
