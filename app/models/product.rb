# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, :price, :site, presence: true
end
