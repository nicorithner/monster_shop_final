require 'rails_helper'

RSpec.describe "Can Delete A Discount" do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    
    @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
    
    
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
  
  
  describe "Discounts have a 'Delete' button and can be deleted from the index page" do
    
    it "There is a 'Delete' link for each discount." do
      discount_1 = @merchant_1.discounts.create(name: "5% off 5", discount_percentage: 5, minimum_quantity: 5)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)

      visit '/merchant/discounts'
      
      within("#discount-#{discount_1.id}") do
        expect(page).to have_link("Delete")
      end
    end
    
    it "Clicking 'Delete' removes the associated discount" do
        discount_1 = @merchant_1.discounts.create(name: "5% off 5", discount_percentage: 5, minimum_quantity: 5)

        visit "/login"
        fill_in :email, with: @m_user.email
        fill_in :password, with: @m_user.password
        click_button "Log In"

        visit '/merchant/discounts'
        within("#discount-#{discount_1.id}") do
          click_link("Delete")
        end

        expect(current_path).to eq("/merchant/discounts")
        @merchant_1.reload
        expect(page).to_not have_content("5% off 5")
        
      end
    end
end