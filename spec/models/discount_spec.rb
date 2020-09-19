require 'rails_helper'

RSpec.describe Discount do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :discount_percentage}
    it {should validate_presence_of :minimum_quantity}
  end
end
