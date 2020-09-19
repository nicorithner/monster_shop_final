require 'rails_helper'

RSpec.describe "New Discount Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    
    @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)

    @ogre = @merchant_1.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @merchant_1.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @hippo = @merchant_1.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 1 )

    @order_1 = @m_user.orders.create!(status: "pending")
    @order_2 = @m_user.orders.create!(status: "pending")
    @order_3 = @m_user.orders.create!(status: "pending")

    @order_item_1 = @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2, fulfilled: false)
    @order_item_2 = @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2, fulfilled: true)
    @order_item_3 = @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)
    @order_item_4 = @order_3.order_items.create!(item: @giant, price: @giant.price, quantity: 2, fulfilled: false)
  end

  describe "Can create a 'bulk' discount for the shop" do

    it "There is link to create new discount that routes to 'merchant/discounts/new'" do
      visit '/merchant'
      expect(page).to have_link("Create Discount")
      click_link("Create Discount")
      expect(current_path).to eq("/merchant/discounts/new")
    end
  end
end