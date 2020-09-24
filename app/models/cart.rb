class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    cart_items = @contents.map do |item_id, _|
      Item.find(item_id)
    end
    cart_items
    updated = cart_items.each do|item| 
      item[:price] = item[:price] * discount_value(item[:id])
    end
    updated
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      price = Item.find(item_id).price * discount_value(item_id)
      grand_total += price * quantity
    end
    grand_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    price = Item.find(item_id).price * discount_value(item_id)
    @contents[item_id.to_s] * price
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end

  def check_for_item_discounts(item_id)
    Item.find(item_id).merchant.discounts
  end

  def match_by_discount_criteria(item_id)
    discounts = check_for_item_discounts(item_id)
    total = count_of(item_id)
    match = discounts.find_by('minimum_quantity <= ?', total)  && 
            total >= discounts.where('minimum_quantity <= ?', total)
                        .order(discount_percentage: :asc)
                        .pluck(:discount_percentage).first
    if match
      discounts.where('minimum_quantity <= ?', total)
      .order(discount_percentage: :asc).first
    else
      "No discount available"
    end
  end

  def discount_value(item_id)
    if match_by_discount_criteria(item_id) == "No discount available"
      1
    else 
      match_by_discount_criteria(item_id).discount_percentage
    end
  end
end
