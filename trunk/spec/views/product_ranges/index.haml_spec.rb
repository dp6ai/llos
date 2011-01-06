require File.dirname(__FILE__) + '/../../spec_helper'

describe "/product_ranges/index.haml" do
  include ProductRangesHelper
  
  before do
    product_range_98 = mock_model(Product_range)
    product_range_98.should_receive(:name).and_return("MyString")
    product_range_99 = mock_model(Product_range)
    product_range_99.should_receive(:name).and_return("MyString")

    assigns[:product_ranges] = [product_range_98, product_range_99]
  end

  it "should render list of product_ranges" do
    render "/product_ranges/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
  end
end
