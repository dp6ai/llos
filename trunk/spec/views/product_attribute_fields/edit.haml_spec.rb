require File.dirname(__FILE__) + '/../../spec_helper'

describe "/product_attribute_fields/edit.haml" do
  include ProductAttributeFieldsHelper
  
  before do
    @product_attribute_fields = mock_model(Product_attribute_fields)
    @product_attribute_fields.stub!(:name).and_return("MyString")
    assigns[:product_attribute_fields] = @product_attribute_fields
  end

  it "should render edit form" do
    render "/product_attribute_fields/edit.haml"
    
    response.should have_tag("form[action=#{product_attribute_field_path(@product_attribute_fields)}][method=post]") do
      with_tag('input#product_attribute_fields_name[name=?]', "product_attribute_fields[name]")
    end
  end
end