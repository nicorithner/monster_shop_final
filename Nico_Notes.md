
# Notes:

Cart:

- I can see the Merchant
- I can see the Item
- @contents shows me the 'id' and the quantity of it in the cart
- I can access the discounts:
  Item.find(item_id).merchant.discounts
- I can obtain a discount value:
  discount_value = Item.find(item_id).merchant.discounts.first.discount_percentage


  1. Is there a discount for this item?
  2. #count_of(item_id) == discount.minimum_quantity?
  3. subtotal_of(item_id) * discount_value

  Methods:

  - #check_for_item_discounts(item_id)
      `Item.find(item_id).merchant.discounts`
  - #match_by_discount_criteria(item_id)

    discounts = Item.find(item_id).merchant.discounts
    #=> returns collection of associations that act like an array

    discounts.select(:minimum_quantity).find_by(minimum_quantity: @contents[item_id.to_s]).minimum_quantity
    #=> returns an integer


  - #discount_value(item_id)
  ```
  def discount_value(item_id)
    if match_by_discount_criteria(item_id)
      match_by_discount_criteria(item_id).discount_percentage
    end
  end
  ```

  All of this materializes inside #subtotal_of(item_id)

  price = unless discount_value(item_id).nil?
    Item.find(item_id).price * discount_value(item_id)
    else
    Item.find(item_id).price
  end

#### Issue!
when the discount criteria is not met then
match_by_discount_criteria(item_id) returns
nil.

matcher:
if not nil and it matches then retun the discount object, else return a string "no discount"

discount value: 
if matcher = "no discount"
return 1
else return 
extracted value
end


#### Issue! 2


discounts.select(:minimum_quantity).find_by('minimum_quantity <= ?', total).minimum_quantity

##### Issue 3!

discount shows in cart but not in the order page.
item price is not changed in the view
-----
When orders_controller create action iterates over the cart items
(cart.items) retrieves the item price.

I need to update the item's price in cart.items

```
[5] pry(#<Cart>)> cart_items[0].price
=> 20.0
[6] pry(#<Cart>)> cart_items[0][:price] = 15
=> 15
[7] pry(#<Cart>)> cart_items[0].price
=> 15.0
```
This worked:
```
updated = cart_items.each {|item| item[:price] = item[:price] * discount_value(item[:id])}
```


## Extension 1 Notes

Create address table with user_id?
how does that affect user creation?

`rails g model Address street city state zip nickname`
`rails db:migrate`
`rails g migration AddUsersToAddresses user:references`
`rails db:migrate`

To create us a nested form_for within user's form.
