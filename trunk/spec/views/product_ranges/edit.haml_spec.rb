require File.dirname(__FILE__) + '/../../spec_helper'

describe "/product_range/edit.haml" do
  include ProductRangesHelper
  
  before do
    @product_range = mock_model(Product_range)
    @product_range.stub!(:name).and_return("MyString")
    assigns[:product_range] = @product_range
  end

  it "should render edit form" do
    render "/product_ranges/edit.haml"
    
    response.should have_tag("form[action=#{product_range_path(@product_range)}][method=post]") do
      with_tag('input#product_range_name[name=?]', "product_range[name]")
    end
  end
end