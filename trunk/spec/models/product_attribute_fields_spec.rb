require File.dirname(__FILE__) + '/../spec_helper'

describe Product_attribute_fields do
  before(:each) do
    @product_attribute_fields = Product_attribute_fields.new
  end

  it "should be valid" do
    @product_attribute_fields.should be_valid
  end
end
