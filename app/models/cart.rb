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
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      grand_total += Item.find(item_id).price * quantity
    end
    grand_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    price = if discount_value(item_id) != 0
      Item.find(item_id).price * discount_value(item_id)
    else
      Item.find(item_id).price
    end
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
    total = @contents[item_id.to_s]
    if total >= discounts.select(:minimum_quantity).find_by(minimum_quantity: total).minimum_quantity
      discounts.find_by(minimum_quantity: total)
    end
  end

  def discount_value(item_id)
    if match_by_discount_criteria(item_id)
      match_by_discount_criteria(item_id).discount_percentage
    end
  end
end
