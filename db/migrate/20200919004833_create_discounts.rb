class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :name
      t.float :discount_percentage
      t.integer :minimum_quantity
    end
  end
end
