require File.dirname(__FILE__) + '/../../spec_helper'

describe "/news_items/index.haml" do
  include NewsItemsHelper
  
  before do
    news_item_98 = mock_model(News_item)
    news_item_98.should_receive(:headline).and_return("MyString")
    news_item_98.should_receive(:content).and_return("MyText")
    news_item_99 = mock_model(News_item)
    news_item_99.should_receive(:headline).and_return("MyString")
    news_item_99.should_receive(:content).and_return("MyText")

    assigns[:news_items] = [news_item_98, news_item_99]
  end

  it "should render list of news_items" do
    render "/news_items/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end
