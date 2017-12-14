class Category < ApplicationRecord
  has_many :category_posts, dependent: :destroy
  has_many :posts, through: :category_posts
end
