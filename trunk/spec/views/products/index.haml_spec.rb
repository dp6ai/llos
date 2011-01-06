require File.dirname(__FILE__) + '/../../spec_helper'

describe "/products/index.haml" do
  include ProductsHelper
  
  before do
    product_98 = mock_model(Product)
    product_98.should_receive(:name).and_return("MyString")
    product_98.should_receive(:description).and_return("MyString")
    product_98.should_receive(:width).and_return("1")
    product_98.should_receive(:depth).and_return("1")
    product_98.should_receive(:height).and_return("1")
    product_98.should_receive(:code).and_return("MyString")
    product_98.should_receive(:product_range_id).and_return("1")
    product_98.should_receive(:highlighted).and_return(false)
    product_99 = mock_model(Product)
    product_99.should_receive(:name).and_return("MyString")
    product_99.should_receive(:description).and_return("MyString")
    product_99.should_receive(:width).and_return("1")
    product_99.should_receive(:depth).and_return("1")
    product_99.should_receive(:height).and_return("1")
    product_99.should_receive(:code).and_return("MyString")
    product_99.should_receive(:product_range_id).and_return("1")
    product_99.should_receive(:highlighted).and_return(false)

    assigns[:products] = [product_98, product_99]
  end

  it "should render list of products" do
    render "/products/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", false, 2)
  end
end
