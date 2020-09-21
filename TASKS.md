# Project Tasks

## Set up

- [x] Check Gemfile
- [x] Run Bundle install and Bundle update
- [x] Run Rails db:reset OR rails db:{drop, create, migrate}
- [x] Run Rspec and verify that tests are passing (there should be only )
- [x] Breakdown project into stories

## Stories

### Discount Model - Validations

- [x] Validation test
- [x] Discount model validates :name, :discount_percentage, :minimum_quantity
- [x] Create table
- [x] Run db:migrate

### Associations - Story 1

#### Merchant/Discount association

- [x] Merchant/Discount Associations tests
  - [x] Discount belongs to merchant
    - [x] Create discount's 'merchant_id' foreign key
  - [x] merchant has_many discounts

### Associations - Story 2

#### Item/Discount association

- [x] Item/Discount Associations test.
  - [x] Discount has_many items THROUGH merchant
  - [x] item has 'discount_id' foreign key

### Story 1

#### Create

- [x] Can create a 'bulk' discount for the shop products. New action/view
  - [x] In the Merchant's Dashboard there is a link to a form to create new item
    - [x] Create feature test
  - [x] There is a form to create new discount
  - [x] It creates a new discount

#### Story 1.1

- [x] Merchant can have multiple discounts. Database

#### Story 1.2

- [] Merchant shop's discounts only apply to merchant's items ONCE they reach a certain quantity of the same item in the same cart/order
- [] Merchant shop's discounts only apply to merchant's items

### Story 2

#### Read

- [x] Merchant can access discount show page through link in dashboard
- [x] Merchant has a discount index page in his shop. Show action/view
  - [x] Can see a list of existing discounts for the shop.
    - [x] Discount 'Name'
    - [x] Discount 'discount_percentage'
    - [x] Discount 'minimum_quantity'

### Story 3
- [x]
#### Update

- [x] Merchant can update discounts. Test #update
- [x] Create Feature tests
- [] Access form via discounts index where there is an 'Edit' link.
- [x] Edit action in the controller
- [x] There is an Edit View page
- [x] There is an Edit form
- [x] User can update the discount info via the form
- [x] User is redirected to discounts index page after submitting changes.

### Story 4

#### Delete

- [x] Can delete discounts. Destroy action

### Story 5

- [x] When a user adds enough value or quantity of a single item to their cart, the bulk discount will automatically show up on the cart page.
  - [x] Discount ONLY applies when item quantity is met with the SAME item.
  - [x] When there is a conflict between two discounts, the greater of the two will be applied
  - [x] Discount DOESN'T applies when items are DIFFERENT.

### Story 6

- [x] Discount shows in the cart page
- [x] Final discounted prices should appear on the orders show page

### Story 7

- [x] A bulk discount from one merchant will only affect items from that merchant in the cart.

-------------------------
##  Users have multiple addresses

#### General Goal

Users will have more than one address associated with their profile. Each address will have a nickname like "home" or "work". Users will choose an address when checking out.

#### Completion Criteria

1. When a user registers they will still provide an address, this will become their first address entry in the database and nicknamed "home".
1. Users need full CRUD ability for addresses from their Profile page.
1. An address cannot be deleted or changed if it's been used in a "shipped" order.
1. When a user checks out on the cart show page, they will have the ability to choose one of their addresses where they'd like the order shipped.
1. If a user deletes all of their addresses, they cannot check out and see an error telling them they need to add an address first. This should link to a page where they add an address.
1. If an order is still pending, the user can change to which address they want their items shipped.

#### Implementation Guidelines

1. Existing tests should still pass. Since you will need to make major changes to your database schema, you will probably break **many** tests. It's recommended that you focus on the completion criteria described above before going back and refactoring your code so that your existing tests still work.
1. Every order show page should display the chosen shipping address.
1. Statistics related to city/state should still work as before.

---

## Tasks

- [] First address user provides gets saved with nickname 'home'

### CRUD

From users's profile page:

1. - [] User can create multiple addresses -> Create
2. - [] User can read a new address -> Read
3. - [] User can update a new address -> Update
4. - [] User can delete a new address -> Destroy

- [] An address cannot be deleted or changed if it's been used in a "shipped" order.
- [] When a user checks out on the cart show page, they will have the ability to choose one of their addresses where they'd like the order shipped.
- [] If a user deletes all of their addresses, they cannot check out and see an error telling them they need to add an address first. This should link to a page where they add an address.
- [] If an order is still pending, the user can change to which address they want their items shipped.

### Set up

- [x] Create Address model test
- [x] Create Address model
  - [x] `validates :street, :city, :state, :zip, :nickname, presence: true`
  - [x] belongs to user
- [x] Create Addresses table
  - [x] Add user_id foreign key
  - [x] User has many addresses

### Story 1 - User can create multiple addresses & User can see a new addresses in profile

- [] Create class method test for Create
  - [] Test it can create multiple
  - [] Test nickname default is 'home'
  - [] New addresses' nickname are custom

- [] Create 'new' feature test
  - [] Creates address from new user registration form
  - [] Creates address from user profile
- [] Create user's profile display feature test
  - [] List of user's addresses in profile
  - [] 'Create New Address' link in profile
  - [] Nickname displays in front of the address. i.e. "work: address info here"