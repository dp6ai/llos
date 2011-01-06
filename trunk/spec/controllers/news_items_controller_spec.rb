require File.dirname(__FILE__) + '/../spec_helper'

describe NewsItemsController, "#route_for" do

  it "should map { :controller => 'news_items', :action => 'index' } to /news_items" do
    route_for(:controller => "news_items", :action => "index").should == "/news_items"
  end
  
  it "should map { :controller => 'news_items', :action => 'new' } to /news_items/new" do
    route_for(:controller => "news_items", :action => "new").should == "/news_items/new"
  end
  
  it "should map { :controller => 'news_items', :action => 'show', :id => 1 } to /news_items/1" do
    route_for(:controller => "news_items", :action => "show", :id => 1).should == "/news_items/1"
  end
  
  it "should map { :controller => 'news_items', :action => 'edit', :id => 1 } to /news_items/1/edit" do
    route_for(:controller => "news_items", :action => "edit", :id => 1).should == "/news_items/1/edit"
  end
  
  it "should map { :controller => 'news_items', :action => 'update', :id => 1} to /news_items/1" do
    route_for(:controller => "news_items", :action => "update", :id => 1).should == "/news_items/1"
  end
  
  it "should map { :controller => 'news_items', :action => 'destroy', :id => 1} to /news_items/1" do
    route_for(:controller => "news_items", :action => "destroy", :id => 1).should == "/news_items/1"
  end
  
end

describe NewsItemsController, "handling GET /news_items" do

  before do
    @news_item = mock_model(News_item)
    News_item.stub!(:find).and_return([@news_item])
  end
  
  def do_get
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should render index template" do
    do_get
    response.should render_template('index')
  end
  
  it "should find all news_items" do
    News_item.should_receive(:find).with(:all).and_return([@news_item])
    do_get
  end
  
  it "should assign the found news_items for the view" do
    do_get
    assigns[:news_items].should == [@news_item]
  end
end

describe NewsItemsController, "handling GET /news_items.xml" do

  before do
    @news_item = mock_model(News_item, :to_xml => "XML")
    News_item.stub!(:find).and_return(@news_item)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all news_items" do
    News_item.should_receive(:find).with(:all).and_return([@news_item])
    do_get
  end
  
  it "should render the found news_item as xml" do
    @news_item.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe NewsItemsController, "handling GET /news_items/1" do

  before do
    @news_item = mock_model(News_item)
    News_item.stub!(:find).and_return(@news_item)
  end
  
  def do_get
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render show template" do
    do_get
    response.should render_template('show')
  end
  
  it "should find the news_item requested" do
    News_item.should_receive(:find).with("1").and_return(@news_item)
    do_get
  end
  
  it "should assign the found news_item for the view" do
    do_get
    assigns[:news_item].should equal(@news_item)
  end
end

describe NewsItemsController, "handling GET /news_items/1.xml" do

  before do
    @news_item = mock_model(News_item, :to_xml => "XML")
    News_item.stub!(:find).and_return(@news_item)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the news_item requested" do
    News_item.should_receive(:find).with("1").and_return(@news_item)
    do_get
  end
  
  it "should render the found news_item as xml" do
    @news_item.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe NewsItemsController, "handling GET /news_items/new" do

  before do
    @news_item = mock_model(News_item)
    News_item.stub!(:new).and_return(@news_item)
  end
  
  def do_get
    get :new
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render new template" do
    do_get
    response.should render_template('new')
  end
  
  it "should create an new news_item" do
    News_item.should_receive(:new).and_return(@news_item)
    do_get
  end
  
  it "should not save the new news_item" do
    @news_item.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new news_item for the view" do
    do_get
    assigns[:news_item].should equal(@news_item)
  end
end

describe NewsItemsController, "handling GET /news_items/1/edit" do

  before do
    @news_item = mock_model(News_item)
    News_item.stub!(:find).and_return(@news_item)
  end
  
  def do_get
    get :edit, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render edit template" do
    do_get
    response.should render_template('edit')
  end
  
  it "should find the news_item requested" do
    News_item.should_receive(:find).and_return(@news_item)
    do_get
  end
  
  it "should assign the found news_item for the view" do
    do_get
    assigns[:news_item].should equal(@news_item)
  end
end

describe NewsItemsController, "handling POST /news_items" do

  before do
    @news_item = mock_model(News_item, :to_param => "1")
    News_item.stub!(:new).and_return(@news_item)
  end
  
  def post_with_successful_save
    @news_item.should_receive(:save).and_return(true)
    post :create, :news_item => {}
  end
  
  def post_with_failed_save
    @news_item.should_receive(:save).and_return(false)
    post :create, :news_item => {}
  end
  
  it "should create a new news_item" do
    News_item.should_receive(:new).with({}).and_return(@news_item)
    post_with_successful_save
  end

  it "should redirect to the new news_item on successful save" do
    post_with_successful_save
    response.should redirect_to(news_item_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe NewsItemsController, "handling PUT /news_items/1" do

  before do
    @news_item = mock_model(News_item, :to_param => "1")
    News_item.stub!(:find).and_return(@news_item)
  end
  
  def put_with_successful_update
    @news_item.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @news_item.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the news_item requested" do
    News_item.should_receive(:find).with("1").and_return(@news_item)
    put_with_successful_update
  end

  it "should update the found news_item" do
    put_with_successful_update
    assigns(:news_item).should equal(@news_item)
  end

  it "should assign the found news_item for the view" do
    put_with_successful_update
    assigns(:news_item).should equal(@news_item)
  end

  it "should redirect to the news_item on successful update" do
    put_with_successful_update
    response.should redirect_to(news_item_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe NewsItemsController, "handling DELETE /news_item/1" do

  before do
    @news_item = mock_model(News_item, :destroy => true)
    News_item.stub!(:find).and_return(@news_item)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the news_item requested" do
    News_item.should_receive(:find).with("1").and_return(@news_item)
    do_delete
  end
  
  it "should call destroy on the found news_item" do
    @news_item.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the news_items list" do
    do_delete
    response.should redirect_to(news_items_url)
  end
end
