describe DiscountRule do
  context "#setup" do
    let(:discount_rule) { DiscountRule.new('001', 2, '£8.50')}
    let(:checkout) { Checkout.new([discount_rule]) }
    let(:store) { checkout.store }
    let(:lavendar_heart) { store.find('001') }
    let(:cuff_links) { store.find('002') }
    let(:tshirt) { store.find('003') }

    let(:tshirt_one) { Item.new(tshirt.code, tshirt.price) }
    let(:tshirt_two) { Item.new(tshirt.code, tshirt.price) }

    let(:lavendar_heart_one) { Item.new(lavendar_heart.code, lavendar_heart.price) }
    let(:lavendar_heart_two) { Item.new(lavendar_heart.code, lavendar_heart.price) }
    let(:lavendar_heart_three) { Item.new(lavendar_heart.code, lavendar_heart.price) }
    let(:cuff_links_one) { Item.new(cuff_links.code, cuff_links.price) }

    context 'when we pass items that not eligible for any discount' do
      let(:items) {[ lavendar_heart_one, cuff_links_one ]}
      let(:rule) { rule.apply(items)}

      it "checks for item's price should not be change" do 
        expect(lavendar_heart_one.price).to eq(lavendar_heart.price)
        expect(cuff_links_one.price).to eq(cuff_links.price)
      end
    end

    context 'when we pass rule and items without enough quantity to apply any discount' do
      let(:items) { [ tshirt_one, tshirt_two, lavendar_heart_two, cuff_links_one ] }
      let(:rule) { discount_rule.apply(items) }

      it "checks for price of an item is not changed" do 
        expect(tshirt_one.price).to eq(tshirt.price)
        expect(tshirt_two.price).to eq(tshirt.price)
        expect(lavendar_heart_one.price).to eq(lavendar_heart_one.price)
        expect(cuff_links_one.price).to eq(cuff_links.price)
      end
    end

    context 'when we pass rule and items with minimum quantity to apply discount' do
      let(:items) { [ tshirt_one, tshirt_two, lavendar_heart_one, lavendar_heart_two, cuff_links_one ] }
      let(:rule) { discount_rule.apply(items) }

      it "checks for price of an item is discounted" do 
        expect(tshirt_one.price).to eq(tshirt.price)
        expect(tshirt_two.price).to eq(tshirt.price)
        expect(lavendar_heart_one.price).to eq(lavendar_heart_one.price)
        expect(cuff_links_one.price).to eq(cuff_links.price)
      end
    end

    context 'pass more than minimum quantity neccessary to apply discount rule' do
      let(:items) { [ tshirt_one, tshirt_two, lavendar_heart_one, lavendar_heart_two, lavendar_heart_three, cuff_links_one ] }
      let(:rule) { discount_rule.apply(items) }

      it "Item price had discounted for lavendar heart" do 
        expect(tshirt_one.price).to eq(tshirt.price)
        expect(tshirt_two.price).to eq(tshirt.price)
        expect(lavendar_heart_one.price).to eq(lavendar_heart_one.price)
        expect(lavendar_heart_two.price).to eq(lavendar_heart_two.price)
        expect(lavendar_heart_three.price).to eq(lavendar_heart_three.price)
        expect(cuff_links_one.price).to eq(cuff_links.price)
      end
    end
  end

end