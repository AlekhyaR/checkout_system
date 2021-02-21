require_relative 'store'
require_relative 'item'
require_relative 'product'

class Checkout
  attr_reader :total, :store, :items

  def initialize(promotion_rules)
    @rules = promotion_rules
    products = create_products
    @store = store_products(products)
    @valid_codes = @store.valid_codes
    @items = []
  end

  def scan(code)
    if @valid_codes.include?(code)
      product = @store.find(code)
      item = Item.new(product.code, product.price)
      @items.push(item)
      true
    else
      false
    end 
  end

  def show
    items = @items.map(&:code).join(', ')
    puts items.size > 0 ? "Basket: #{items}" : 'No items to checkout'
    puts "Total price expected: £#{self.total}"
  end

  def total
    if rules_has_percent_discount_rule?(@rules)
      filter_rules_and_apply
      process_percent_discount_rule
    else
      @rules.each{ |rule| rule.apply(@items) }
      calculate_total_amount
    end
  end

  def filter_rules_and_apply
    rules = rules_excluding_percent_discount_rule(@rules)
    rules.each{ |rule| rule.apply(@items) } unless rules.nil?
  end

  def process_percent_discount_rule
    total_amount = calculate_total_amount
    percent_discount_rule = percent_discount_rule_selected(@rules)
    percent_discount_rule.apply(total_amount)
  end

  def calculate_total_amount
    @items.inject(0.0){ |total, item| total += Numeric.formatted_price(item.price)}
  end

  def percent_discount_rule_selected(rules)
    rules.select {|rule| rule.class == PercentDiscountRule }[0]
  end

  def rules_has_percent_discount_rule?(rules)
    rules.any? {|rule| rule.class == PercentDiscountRule }
  end

  def rules_excluding_percent_discount_rule(rules)
    rules - [percent_discount_rule_selected(rules)]
  end

  def create_products
    Product.create
  end

  def store_products(products)
    Store.new(products[0], products[1], products[2])
  end
end
