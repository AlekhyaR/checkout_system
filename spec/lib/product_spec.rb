describe Product do
  let(:products) { Product.create }

  describe '#create' do
    it "checks whether new products are created correctly using csv file" do 
      expect(products[0].code).to eq("001")
      expect(products[1].name).to eq("Personalised cufflinks")
      expect(products[2].price).to eq("£19.95")
    end
  end

  describe '#to_a' do
    it "checks array conversion" do 
      expect(products[0].to_a).to eq(["001","Lavender heart", "£9.25"])
    end
  end
end