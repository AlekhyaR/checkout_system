class Numeric 
  def self.formatted_price(price)
    price.split("£")[1].to_f.round(2)
  end

  def self.add_currency(price)
    '£%.2f' % price
  end
end