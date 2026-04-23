module Likeable
  extend ActiveSupport::Concern
  
  included do
    has_many :photo_likes, dependent: :destroy
  end
  
  def liked_by?(user)
    photo_likes.exists?(user: user)
  end

  def like_button_turbo_method(user)
    liked_by?(user) ? :delete : :post
  end

  def like_button_star_svg(user)
    liked_by?(user) ? "star-fill.svg" : "star-line.svg"
  end

  def like_button_star_svg_liked_class(user)
    liked_by?(user) ? " liked" : ""
  end
end