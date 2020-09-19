class AddDiscountsToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :discount, foreign_key: true
  end
end
