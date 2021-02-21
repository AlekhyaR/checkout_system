describe BuyTwoGetOneRule do
  describe '#initialize' do
    let(:rule) { BuyTwoGetOne.new('002') }
    let(:checkout) { Checkout.new([rule]) }
    let(:store) { checkout.store }

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
    let(:cuff_links_two) { Item.new(cuff_links.code, cuff_links.price) }

    context 'when we pass items that not eligible for any discount' do
      before do
        items = [lavendar_heart_one, cuff_links_one]
        rule.apply(items)
      end

      it "checks for item's price should not be change" do 
        expect(lavendar_heart_one.price).to eq(lavendar_heart.price)
        expect(cuff_links_one.price).to eq(cuff_links.price)
      end
    end

    context 'when checkout has an even number of products to apply buy two get one free' do
      before do
        items = [ tshirt_one, tshirt_two, lavendar_heart_two, cuff_links_one, cuff_links_two ]
        rule.apply(items)  
      end

      it "checks one of cufflink's items price should be equal to zero and remaining items price should not be changed" do 
        expect(tshirt_one.price).to eq(tshirt.price)
        expect(tshirt_two.price).to eq(tshirt.price)
        expect(lavendar_heart_one.price).to eq(lavendar_heart_one.price)
        expect(cuff_links_one.price).to eq(cuff_links.price)
        expect(cuff_links_two.price).to eq(0)
      end
    end
  end
end