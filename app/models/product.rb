class Product < ApplicationRecord
  validates :name, :price, :site, presence: true
end
