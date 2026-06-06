class Stock < ApplicationRecord
  validates :category, :name, :price, :image_path, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
