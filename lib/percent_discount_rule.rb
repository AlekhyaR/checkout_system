class PercentDiscountRule
  attr_accessor :threshold_amount, :discount_percent
  
  def initialize(threshold_amount, discount_percent)
    @threshold_amount = threshold_amount
    @discount_percent = discount_percent
  end

  def apply(total_amount)
    eligibile?(total_amount) ? (total_amount - (total_amount * discount_percent)).round(2) : total_amount
  end

  def eligibile?(total_amount)
    total_amount > Numeric.formatted_price(threshold_amount)
  end
end