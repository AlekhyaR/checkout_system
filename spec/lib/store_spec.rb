describe Store do
  let(:product_one) { Product.new('001', 'Lavendar Heart', '£9.50') }
  let(:product_two) { Product.new('002', 'Personalised cufflinks', '£45.00') }
  let(:product_three) { Product.new('003', 'Lavendar Hearts', '£19.95') }
  let(:store) { Store.new(product_one, product_two, product_three) }

  context 'check quantity of products is correct' do
    it 'check store has 3 products' do
      expect(store.products_quantity).to eq(3)
    end 
  end

  context 'test find product method' do
    let(:product) { store.products.first }
    it 'should return correct product' do
      expect([product.code, product.name, product.price]).to eq(store.find(product.code).to_a)
    end 
  end

  context 'test store creates a new product' do
    before do 
      store.add_product('004', 'sample product', '£23.02')
    end
    let(:product) { store.find("004") }

    it 'should return correct product' do
      expect(store.products_quantity).to eq(4)
      expect([product.code, product.name, product.price]).to eq(store.find(product.code).to_a)
    end 
  end

  context 'test valid codes method' do
    let(:valid_codes) { store.valid_codes }
    let(:codes) { [] }
    before do 
      store.products.each{ |product| codes.push(product.code) }
    end

    it 'should return correct product' do
      expect(codes).to eq(valid_codes)
    end 
  end
end

