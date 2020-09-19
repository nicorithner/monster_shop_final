# Project Tasks

## Set up

- [x] Check Gemfile
- [x] Run Bundle install and Bundle update
- [x] Run Rails db:reset OR rails db:{drop, create, migrate}
- [x] Run Rspec and verify that tests are passing (there should be only )
- [x] Breakdown project into stories

## Stories

### Discount Validation

- [] Validation test
- [] Discount model validates :name, :discount_percentage, :minimum_quantity
- [] Create table
- [] Run db:migrate

### Associations - Story 1

#### Merchant/Discount association

- [] Merchant/Discount Associations test
  - [] Discount belongs to merchant
  - [] merchant has_many discounts
    - [] Create items merchant_id foreign key

### Associations - Story 2

#### Item/Discount association

- [] Item/Discount Associations test.
  - [] Discount has_many items
  - [] item has one discount
    - [] Create items discount_id foreign key

### Story 1

#### Create

- [] Can create a 'bulk' discount for the shop products. New action/view
  - [] There is a form to create new item
  - [] Discount ONLY applies when item quantity is met with the SAME item.
  - [] Discount DOESN'T applies when items are DIFFERENT.
  - [] Merchant can have multiple discounts. Database
  - [] Merchant shop's discounts only apply to merchant's items

### Story 2

#### Read

- [] Merchant can access discount show page through link in dashboard
- [] Merchant has a discount show page in his shop. Show action/view
  - [] Can see a list of existing discounts for the shop.
    - [] Discount 'Name'
    - [] Discount 'Description'

### Story 3

#### Update

- [] Can edit shop discounts. Update action/view

### Story 4

#### Delete

- [] Can delete discounts. Destroy action

### Story 5

- [] When there is a conflict between two discounts, the greater of the two will be applied

### Story 6

- [] Final discounted prices should appear on the orders show page
