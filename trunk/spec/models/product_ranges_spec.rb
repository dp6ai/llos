require File.dirname(__FILE__) + '/../spec_helper'

describe Product_range do
  before(:each) do
    @product_range = Product_range.new
  end

  it "should be valid" do
    @product_range.should be_valid
  end
end
