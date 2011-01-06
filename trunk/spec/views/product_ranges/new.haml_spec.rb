require File.dirname(__FILE__) + '/../../spec_helper'

describe "/product_ranges/new.haml" do
  include ProductRangesHelper
  
  before do
    @product_range = mock_model(Product_range)
    @product_range.stub!(:new_record?).and_return(true)
    @product_range.stub!(:name).and_return("MyString")
    assigns[:product_range] = @product_range
  end

  it "should render new form" do
    render "/product_ranges/new.haml"
    
    response.should have_tag("form[action=?][method=post]", admin_product_ranges_path) do
      with_tag("input#product_range_name[name=?]", "product_range[name]")
    end
  end
end
