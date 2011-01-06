require File.dirname(__FILE__) + '/../../spec_helper'

describe "/products/show.haml" do
  include ProductsHelper
  
  before do
    @product = mock_model(Product)
    @product.stub!(:name).and_return("MyString")
    @product.stub!(:description).and_return("MyString")
    @product.stub!(:width).and_return("1")
    @product.stub!(:depth).and_return("1")
    @product.stub!(:height).and_return("1")
    @product.stub!(:code).and_return("MyString")
    @product.stub!(:product_range_id).and_return("1")
    @product.stub!(:highlighted).and_return(false)

    assigns[:product] = @product
  end

  it "should render attributes in <p>" do
    render "/products/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/MyString/)
    response.should have_text(/als/)
  end
end

