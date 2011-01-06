require File.dirname(__FILE__) + '/../../spec_helper'

describe "/product_attribute_fields/index.haml" do
  include ProductAttributeFieldsHelper
  
  before do
    product_attribute_fields_98 = mock_model(Product_attribute_fields)
    product_attribute_fields_98.should_receive(:name).and_return("MyString")
    product_attribute_fields_99 = mock_model(Product_attribute_fields)
    product_attribute_fields_99.should_receive(:name).and_return("MyString")

    assigns[:product_attribute_fields] = [product_attribute_fields_98, product_attribute_fields_99]
  end

  it "should render list of product_attribute_fields" do
    render "/product_attribute_fields/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
  end
end
