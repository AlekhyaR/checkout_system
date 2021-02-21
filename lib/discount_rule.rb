class DiscountRule
  attr_accessor :discount_price_on_item

  def initialize(code, quantity, discount_price_on_item)
    @code = code
    @quantity = quantity
    @discount_price_on_item = discount_price_on_item
  end

  def apply(items)
    selected_items = items.select{ |i| i.code == @code}
    selected_items.each{ |item| item.price = @discount_price_on_item } if selected_items.size >= @quantity
  end
end