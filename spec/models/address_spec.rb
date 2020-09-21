require 'rails_helper'

RSpec.describe Address, type: :model do

  describe 'Relationships' do
    it {should belong_to :user}
  end

  describe 'Validations' do
    it {should validate_presence_of :street}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :nickname}
  end

  describe "Address Model" do
    before :each do
      
      # @user = User.create!(name: 'User', email: 'megan@example.com', password: 'securepassword')
      # @user_1 = User.create!(name: 'User 1', email: 'megan@example.com', password: 'securepassword')
      # @admin = User.create!(name: 'Admin', email: 'admin@example.com', password: 'securepassword')

      # @user_address = @user.addresses.create!(street: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 'home')
      # @admin_address = @admin.addresses.create!(street: '321 Main St', city: 'Denver', state: 'CO', zip: 80202, nickname: 'home')
    end

    describe "Instance method" do
      it "#create" do
        
      end
    end
  end
end
