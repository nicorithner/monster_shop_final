require 'rails_helper'

RSpec.describe "Edit Discount Page" do
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

    @discount_1 = @merchant_1.discounts.create(name: "5% off 5", discount_percentage: 5, minimum_quantity: 5)
    @discount_2 = @merchant_1.discounts.create(name: "10% off 10", discount_percentage: 10, minimum_quantity: 10)
  end

  describe "Merchant can edit discount through a form in a discount edit page." do
    describe "It accesses 'merchant/discounts/:id/edit' using link in discount index" do

      it "There is an 'Edit' link." do
        visit '/merchant/discounts'

        within("#discount-#{@discount_1.id}") do
          expect(page).to have_link("Edit")
        end
      end

      it "Clicking edit leads to edit page for that discount" do
        visit '/merchant/discounts'
        within("#discount-#{@discount_1.id}") do
          click_link("Edit")
        end
        id = @discount_1.id
        expect(current_path).to eq("/merchant/discounts/#{id}/edit")
      end
    end

    describe "There is form to edit discount. clicking 'Edit' redirects to merchant's discount index where the edits are reflected in the discount's information" do

      it "There is a form" do
        visit "/merchant/discounts/#{@discount_1.id}/edit"

        expect(page).to have_content("Edit '#{@discount_1.name}' Discount")
        find_field('Name').value
        find_field('Discount percentage')
        find_field('Minimum quantity')
        find_button('Edit')
      end

      it "After making changes clicking 'Edit' redirects back to the index where edits are visible" do
        visit "/merchant/discounts/#{@discount_1.id}/edit"

        name = '5% off 5 M&Ms Small Packages'
        percentage = 5
        minimum = 5

        fill_in 'Name', with: name
        fill_in 'Discount percentage', with: percentage
        fill_in 'Minimum quantity', with: minimum
        click_button 'Edit'

        expect(current_path).to eq('/merchant/discounts')

        within("#discount-#{@discount_1.id}") do
          expect(page).to have_content("5% off 5 M&Ms Small Packages")
        end
      end
    end
  end
end