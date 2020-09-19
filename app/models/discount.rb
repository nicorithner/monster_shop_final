class Discount < ApplicationRecord
  validates :name, :discount_percentage, :minimum_quantity, presence: true
end