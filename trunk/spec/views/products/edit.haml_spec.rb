require File.dirname(__FILE__) + '/../../spec_helper'

describe "/product/edit.haml" do
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

  it "should render edit form" do
    render "/products/edit.haml"
    
    response.should have_tag("form[action=#{admin_product_path(@product)}][method=post]") do
      with_tag('input#product_name[name=?]', "product[name]")
      with_tag('input#product_description[name=?]', "product[description]")
      with_tag('input#product_width[name=?]', "product[width]")
      with_tag('input#product_depth[name=?]', "product[depth]")
      with_tag('input#product_height[name=?]', "product[height]")
      with_tag('input#product_code[name=?]', "product[code]")
      with_tag('input#product_highlighted[name=?]', "product[highlighted]")
    end
  end
end