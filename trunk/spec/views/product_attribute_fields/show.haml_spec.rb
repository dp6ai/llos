require File.dirname(__FILE__) + '/../../spec_helper'

describe "/product_attribute_fields/show.haml" do
  include ProductAttributeFieldsHelper
  
  before do
    @product_attribute_fields = mock_model(Product_attribute_fields)
    @product_attribute_fields.stub!(:name).and_return("MyString")

    assigns[:product_attribute_fields] = @product_attribute_fields
  end

  it "should render attributes in <p>" do
    render "/product_attribute_fields/show.haml"
    response.should have_text(/MyString/)
  end
end

