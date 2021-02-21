describe Numeric do
  context '#formatted_price' do
    let(:price) {'£23.23'}

    it 'checks whether formatted price returns correct price in float value' do 
      expect(described_class.formatted_price(price)).to eq(23.23)
    end
  end
end