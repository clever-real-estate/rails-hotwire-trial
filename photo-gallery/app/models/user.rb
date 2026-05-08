# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable

  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo
end
