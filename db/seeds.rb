# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.destroy_all
Order.destroy_all
OrderItem.destroy_all
User.destroy_all
Merchant.destroy_all


##=================== Merchants 
@megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
@brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
@sal = Merchant.create!(name: 'Sals Salamanders', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

##=================== Items 
@ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
@giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
@hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )



##=================== Users
@user_1 = User.create!(name: 'Tom', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'tom@gmail.com', password: 'securepassword')
@user_2 = User.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'IA', zip: 80218, email: 'megan@gmail.com', password: 'securepassword')

##=================== Orders  
@order_1 = @user_1.orders.create!
@order_2 = @user_2.orders.create!(status: 1)
@order_3 = @user_2.orders.create!(status: 1)

##=================== Order_Items
@order_item_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
@order_item_2 = @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)
@order_item_3 = @order_2.order_items.create!(item: @giant, price: @hippo.price, quantity: 2)
@order_item_4 = @order_2.order_items.create!(item: @ogre, price: @hippo.price, quantity: 2)
