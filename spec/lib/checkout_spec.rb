describe Checkout do
  context "#initialize" do
    let(:rule_one) { DiscountRule.new('001', 2, '£8.50') }
    let(:rule_two) { PercentDiscountRule.new('£60', 0.1)}
    let(:checkout_with_rule_one) { Checkout.new([rule_one]) }
    let(:checkout_with_rule_two) { Checkout.new([rule_two])}
    let(:checkout) { Checkout.new([ rule_one, rule_two ])}
    let(:store) { checkout.store }

    it "check whether checkout is able to scan a new product" do
      expect(checkout.scan("001")).to eq(true)
      expect(checkout.scan("004")).to eq(false)
      expect(checkout.scan("003")).to eq(true)
    end

    it "check that total works correctly for rule one" do
      checkout_with_rule_one.scan("001")
      checkout_with_rule_one.scan("003")
      checkout_with_rule_one.scan("001")
      expect(checkout_with_rule_one.total).to eq(36.95)
    end

    it "check that total works correctly for rule two" do
      checkout_with_rule_two.scan("001")
      checkout_with_rule_two.scan("003")
      checkout_with_rule_two.scan("002")
      expect(checkout_with_rule_two.total).to eq(66.78)
    end

    it "check that total works correctly for rule one and rule two" do
      checkout.scan("001")
      checkout.scan("003")
      checkout.scan("002")
      expect(checkout.total).to eq(66.78)
    end

    it "check that total works correctly for rule one" do
      checkout.scan("001")
      checkout.scan("003")
      checkout.scan("001")
      expect(checkout.total).to eq(36.95)
    end

    it "check that total works correctly for rule one" do
      checkout.scan("001")
      checkout.scan("002")
      checkout.scan("001")
      checkout.scan("003")
      expect(checkout.total).to eq(73.76)
    end

  end
end