describe PercentDiscountRule do
  describe '#initialize' do
    let(:rule1)  { DiscountRule.new('001', 2, '£8.50') }
    let(:rule2)  { PercentDiscountRule.new('£60', 0.1) }
    let(:checkout) { Checkout.new([rule1, rule2]) }
    
    let(:store) { checkout.store }
    let(:lavendar_heart) { store.find('001') }
    let(:cuff_links) { store.find('002') }
    let(:tshirt) { store.find('003') }

    let(:tshirt_one) { Item.new(tshirt.code, tshirt.price) }
    let(:tshirt_two) { Item.new(tshirt.code, tshirt.price) }
    let(:tshirt_three) { Item.new(tshirt.code, tshirt.price) }

    let(:lavendar_heart_one) { Item.new(lavendar_heart.code, lavendar_heart.price) }
    let(:lavendar_heart_two) { Item.new(lavendar_heart.code, lavendar_heart.price) }
    let(:lavendar_heart_three) { Item.new(lavendar_heart.code, lavendar_heart.price) }
    let(:cuff_links_one) { Item.new(cuff_links.code, cuff_links.price) }

    context 'when we pass items that not eligible for any discount' do
      let(:items) {[ lavendar_heart_one, cuff_links_one ]}
      let(:total) { checkout.total }
      let(:percent_discount_rule) { rule2.apply(total)}

      it "checks for item's price should not be change" do 
        expect(total).to eq(percent_discount_rule)
      end
    end

    context 'when we pass items that are eligible for item discount rule' do
      let(:items) {[ lavendar_heart_one, lavendar_heart_two, lavendar_heart_three, cuff_links_one ]}
      let(:total) { checkout.total }
      let(:percent_discount_rule) { rule2.apply(total)}

      it "then item's total price should be discounted to discount rule price" do 
        expect(total).to eq(percent_discount_rule)
      end
    end

    context 'when we pass items that eligible for percent discount rule' do
      let(:items) {[ lavendar_heart_one, tshirt_one, cuff_links_one ]}
      let(:total) { checkout.total }
      let(:percent_discount_rule) { rule2.apply(total)}

      it "then item's total price should be discounted to percent discount rule price" do 
        expect(total).to eq(percent_discount_rule)
      end
    end
  end
end