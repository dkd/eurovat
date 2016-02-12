$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
require 'rubygems'
require 'eurovat'

describe Eurovat do
  # NL855263180B01 is Phusion's VAT number. If we ever go out of business replace
  # it with any other valid VAT number to have the unit tests pass.

  it "works" do
    @eurovat = Eurovat.new
    expect(@eurovat.check_vat_number('NL855263180B01')).to be true
    expect(@eurovat.check_vat_number('NL010101010B99')).to be false
  end

  it "strips away spaces and dots" do
    @eurovat = Eurovat.new
    expect(@eurovat.check_vat_number('nl8552.63 180.b01')).to be true
  end

  it "raises InvalidFormatError if the VAT number is not formatted like one" do
    @eurovat = Eurovat.new
    expect(lambda { @eurovat.check_vat_number('foobar') }).to raise_error(Eurovat::InvalidFormatError)
    expect(lambda { @eurovat.check_vat_number('foobar!') }).to raise_error(Eurovat::InvalidFormatError)
  end

  it "always charges VAT if the customer is from one's own country" do
    expect(Eurovat.must_charge_vat?('Netherlands', nil)).to be true
    expect(Eurovat.must_charge_vat?('Netherlands', 'NL855263180B01')).to be true
  end

  it "doesn't charge VAT if the customer is outside one's own country and supplied a VAT number" do
    expect(Eurovat.must_charge_vat?('Germany', 'NL855263180B01')).to be false
    expect(Eurovat.must_charge_vat?('United States', 'NL855263180B01')).to be false
  end

  it "charges VAT if the customer is outside one's own country, but inside the EU, and didn't supply a VAT number" do
    expect(Eurovat.must_charge_vat?('Germany', nil)).to be true
  end

  it "doesn't charge VAT if the customer is outside one's own country, outside the EU, and didn't supply a VAT number" do
    expect(Eurovat.must_charge_vat?('United States', nil)).to be false
  end
end
