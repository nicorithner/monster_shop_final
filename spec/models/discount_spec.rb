require 'rails_helper'

RSpec.describe Discount do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :discount_percentage}
    it {should validate_presence_of :minimum_quantity}
  end

  describe 'Associations' do
    it {should belong_to :merchant}
    it {should have_many(:items).through(:merchant)}
  end

  before :each do
    @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    
    @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
  end

  describe "Merchant can have multiple discounts. Database" do
    it "#create" do
      @discount_1 = @merchant_1.discounts.create(name: "5% off 5", discount_percentage: 5, minimum_quantity: 5)
      @discount_2 = @merchant_1.discounts.create(name: "5% off 5", discount_percentage: 5, minimum_quantity: 5)

      expect(@merchant_1.discounts.count).to eq(2)
    end
  end
end
