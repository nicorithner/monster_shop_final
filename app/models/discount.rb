class Discount < ApplicationRecord
  validates :name, :discount_percentage, :minimum_quantity, presence: true
  belongs_to :merchant
end