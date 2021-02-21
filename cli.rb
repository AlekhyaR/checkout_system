require_relative 'lib/checkout.rb'
require_relative 'lib/discount_rule.rb'
require_relative 'lib/percent_discount_rule.rb'
require_relative 'lib/buy_two_get_one_rule.rb'
require_relative 'lib/numeric.rb'

# Print variables
def prompt
  print '> '
end

def breakline
  puts "\n"
end

# Initialize objects

@rule_one = DiscountRule.new('001', 2, '£8.50')
@rule_two = PercentDiscountRule.new('£60', 0.1)
@rule_three = BuyTwoGetOneRule.new('002')
@checkout = Checkout.new([@rule_one])
# Uncomment the next line if you want to include the additional rule Buy Two Get One Product rule
# @checkout = Checkout.new([ @rule_one, @rule_two, @rule_three ])
@store = @checkout.store

option = 0
while option != 6
  puts """
    Welcome to Checkout System store

    1. Inventory
    2. Find product
    3. Create product
    4. Scan product
    5. Total
    6. Exit
  """
  prompt

  option = gets.chomp.to_i
  breakline

  case option
  when 1
    puts @store.list

  when 2
    puts 'Please enter product code'
    prompt
    code = gets.chomp

    product = @store.find(code)
    breakline
    puts product.nil? ? 'Sorry, this product does not exist' : product.to_s
  when 3
    puts 'Please enter code:'
    prompt
    code = gets.chomp
    prompt
    puts 'Please enter name:'
    prompt
    name = gets.chomp
    puts 'Please enter price:'
    prompt
    price = gets.chomp.to_f

    @store.add_product(code, name, price)
    product = @store.find(code)
    breakline
    puts 'The next product was created successfully'
    puts product.to_s
  when 4
    puts 'Please enter code:'
    prompt
    code = gets.chomp

    breakline
    puts @checkout.scan(code) ? 'The product was added successfully' : 'This product does not exist'
  when 5
    @checkout.show
  when 6
    puts 'Bye bye user!'
  else
    puts 'Please select a correct option'
  end
end