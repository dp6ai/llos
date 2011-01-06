require File.dirname(__FILE__) + '/../../spec_helper'

describe "/news_items/new.haml" do
  include NewsItemsHelper
  
  before do
    @news_item = mock_model(News_item)
    @news_item.stub!(:new_record?).and_return(true)
    @news_item.stub!(:headline).and_return("MyString")
    @news_item.stub!(:content).and_return("MyText")
    assigns[:news_item] = @news_item
  end

  it "should render new form" do
    render "/news_items/new.haml"
    
    response.should have_tag("form[action=?][method=post]", news_items_path) do
      with_tag("input#news_item_headline[name=?]", "news_item[headline]")
      with_tag("textarea#news_item_content[name=?]", "news_item[content]")
    end
  end
end
