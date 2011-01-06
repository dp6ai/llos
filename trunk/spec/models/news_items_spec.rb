require File.dirname(__FILE__) + '/../spec_helper'

describe News_item do
  before(:each) do
    @news_item = News_item.new
  end

  it "should be valid" do
    @news_item.should be_valid
  end
end
