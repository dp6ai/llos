require File.dirname(__FILE__) + '/../../spec_helper'

describe "/news_items/show.haml" do
  include NewsItemsHelper
  
  before do
    @news_item = mock_model(News_item)
    @news_item.stub!(:headline).and_return("MyString")
    @news_item.stub!(:content).and_return("MyText")

    assigns[:news_item] = @news_item
  end

  it "should render attributes in <p>" do
    render "/news_items/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

