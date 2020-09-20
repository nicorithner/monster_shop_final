require 'rails_helper'

RSpec.describe Cart do
  describe 'Instance Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 2 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @discount_1 = @megan.discounts.create(name: "5% off 5", discount_percentage: 0.95, minimum_quantity: 5)
      @discount_2 = @megan.discounts.create(name: "10% off 10", discount_percentage: 0.90, minimum_quantity: 10)

      @cart = Cart.new({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2
        })
    end

    it '.contents' do
      expect(@cart.contents).to eq({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2
        })
    end

    it '.add_item()' do
      @cart.add_item(@hippo.id.to_s)

      expect(@cart.contents).to eq({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2,
        @hippo.id.to_s => 1
        })
    end

    it '.count' do
      expect(@cart.count).to eq(3)
    end

    it '.items' do
      expect(@cart.items).to eq([@ogre, @giant])
    end

    it '.grand_total' do
      expect(@cart.grand_total).to eq(120)
    end

    it '.count_of()' do
      expect(@cart.count_of(@ogre.id)).to eq(1)
      expect(@cart.count_of(@giant.id)).to eq(2)
    end

    it '.limit_reached?()' do
      expect(@cart.limit_reached?(@ogre.id)).to eq(false)
      expect(@cart.limit_reached?(@giant.id)).to eq(true)
    end

    it '.less_item()' do
      @cart.less_item(@giant.id.to_s)

      expect(@cart.count_of(@giant.id)).to eq(1)
    end

    it "#check_for_item_discounts" do
      4.times do
        @cart.add_item(@ogre.id.to_s)
      end
      expect(@cart.count_of(@ogre.id)).to eq(5)
      expect(@cart.check_for_item_discounts(@ogre.id)).to eq([@discount_1, @discount_2])   
    end

    it "#match_by_discount_criteria" do
      4.times do
        @cart.add_item(@ogre.id.to_s)
      end
      expect(@cart.count_of(@ogre.id)).to eq(5)
      expect(@cart.match_by_discount_criteria(@ogre.id)).to eq(@discount_1)   
    end

    it "#discount_value" do
      4.times do
        @cart.add_item(@ogre.id.to_s)
      end
      expect(@cart.count_of(@ogre.id)).to eq(5)
      expect(@cart.discount_value(@ogre.id)).to eq(0.95)   
    end

    it "#subtotal_of" do
      expect(@cart.subtotal_of(@ogre.id)).to eq(20)
      expect(@cart.count_of(@ogre.id)).to eq(1)
      
      4.times do
        @cart.add_item(@ogre.id.to_s)
      end
      expect(@cart.count_of(@ogre.id)).to eq(5)
      expect(@cart.subtotal_of(@ogre.id)).to eq(95)   
    end
  end
end
