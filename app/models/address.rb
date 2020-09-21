class Address < ApplicationRecord
  validates :street, :city, :state, :zip, :nickname, presence: true
  belongs_to :user
end
