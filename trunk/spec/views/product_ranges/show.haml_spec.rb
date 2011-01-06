require File.dirname(__FILE__) + '/../../spec_helper'

describe "/product_ranges/show.haml" do
  include ProductRangesHelper
  
  before do
    @product_range = mock_model(Product_range)
    @product_range.stub!(:name).and_return("MyString")

    assigns[:product_range] = @product_range
  end

  it "should render attributes in <p>" do
    render "/product_ranges/show.haml"
    response.should have_text(/MyString/)
  end
end

