require File.dirname(__FILE__) + '/../spec_helper'

describe ProductRangesController, "#route_for" do

  it "should map { :controller => 'product_ranges', :action => 'index' } to /product_ranges" do
    route_for(:controller => "product_ranges", :action => "index").should == "/product_ranges"
  end
  
  it "should map { :controller => 'product_ranges', :action => 'new' } to /product_ranges/new" do
    route_for(:controller => "product_ranges", :action => "new").should == "/product_ranges/new"
  end
  
  it "should map { :controller => 'product_ranges', :action => 'show', :id => 1 } to /product_ranges/1" do
    route_for(:controller => "product_ranges", :action => "show", :id => 1).should == "/product_ranges/1"
  end
  
  it "should map { :controller => 'product_ranges', :action => 'edit', :id => 1 } to /product_ranges/1/edit" do
    route_for(:controller => "product_ranges", :action => "edit", :id => 1).should == "/product_ranges/1/edit"
  end
  
  it "should map { :controller => 'product_ranges', :action => 'update', :id => 1} to /product_ranges/1" do
    route_for(:controller => "product_ranges", :action => "update", :id => 1).should == "/product_ranges/1"
  end
  
  it "should map { :controller => 'product_ranges', :action => 'destroy', :id => 1} to /product_ranges/1" do
    route_for(:controller => "product_ranges", :action => "destroy", :id => 1).should == "/product_ranges/1"
  end
  
end

describe ProductRangesController, "handling GET /product_ranges" do

  before do
    @product_range = mock_model(Product_range)
    Product_range.stub!(:find).and_return([@product_range])
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
  
  it "should find all product_ranges" do
    Product_range.should_receive(:find).with(:all).and_return([@product_range])
    do_get
  end
  
  it "should assign the found product_ranges for the view" do
    do_get
    assigns[:product_ranges].should == [@product_range]
  end
end

describe ProductRangesController, "handling GET /product_ranges.xml" do

  before do
    @product_range = mock_model(Product_range, :to_xml => "XML")
    Product_range.stub!(:find).and_return(@product_range)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all product_ranges" do
    Product_range.should_receive(:find).with(:all).and_return([@product_range])
    do_get
  end
  
  it "should render the found product_range as xml" do
    @product_range.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ProductRangesController, "handling GET /product_ranges/1" do

  before do
    @product_range = mock_model(Product_range)
    Product_range.stub!(:find).and_return(@product_range)
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
  
  it "should find the product_range requested" do
    Product_range.should_receive(:find).with("1").and_return(@product_range)
    do_get
  end
  
  it "should assign the found product_range for the view" do
    do_get
    assigns[:product_range].should equal(@product_range)
  end
end

describe ProductRangesController, "handling GET /product_ranges/1.xml" do

  before do
    @product_range = mock_model(Product_range, :to_xml => "XML")
    Product_range.stub!(:find).and_return(@product_range)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the product_range requested" do
    Product_range.should_receive(:find).with("1").and_return(@product_range)
    do_get
  end
  
  it "should render the found product_range as xml" do
    @product_range.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ProductRangesController, "handling GET /product_ranges/new" do

  before do
    @product_range = mock_model(Product_range)
    Product_range.stub!(:new).and_return(@product_range)
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
  
  it "should create an new product_range" do
    Product_range.should_receive(:new).and_return(@product_range)
    do_get
  end
  
  it "should not save the new product_range" do
    @product_range.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new product_range for the view" do
    do_get
    assigns[:product_range].should equal(@product_range)
  end
end

describe ProductRangesController, "handling GET /product_ranges/1/edit" do

  before do
    @product_range = mock_model(Product_range)
    Product_range.stub!(:find).and_return(@product_range)
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
  
  it "should find the product_range requested" do
    Product_range.should_receive(:find).and_return(@product_range)
    do_get
  end
  
  it "should assign the found product_range for the view" do
    do_get
    assigns[:product_range].should equal(@product_range)
  end
end

describe ProductRangesController, "handling POST /product_ranges" do

  before do
    @product_range = mock_model(Product_range, :to_param => "1")
    Product_range.stub!(:new).and_return(@product_range)
  end
  
  def post_with_successful_save
    @product_range.should_receive(:save).and_return(true)
    post :create, :product_range => {}
  end
  
  def post_with_failed_save
    @product_range.should_receive(:save).and_return(false)
    post :create, :product_range => {}
  end
  
  it "should create a new product_range" do
    Product_range.should_receive(:new).with({}).and_return(@product_range)
    post_with_successful_save
  end

  it "should redirect to the new product_range on successful save" do
    post_with_successful_save
    response.should redirect_to(product_range_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe ProductRangesController, "handling PUT /product_ranges/1" do

  before do
    @product_range = mock_model(Product_range, :to_param => "1")
    Product_range.stub!(:find).and_return(@product_range)
  end
  
  def put_with_successful_update
    @product_range.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @product_range.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the product_range requested" do
    Product_range.should_receive(:find).with("1").and_return(@product_range)
    put_with_successful_update
  end

  it "should update the found product_range" do
    put_with_successful_update
    assigns(:product_range).should equal(@product_range)
  end

  it "should assign the found product_range for the view" do
    put_with_successful_update
    assigns(:product_range).should equal(@product_range)
  end

  it "should redirect to the product_range on successful update" do
    put_with_successful_update
    response.should redirect_to(product_range_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe ProductRangesController, "handling DELETE /product_range/1" do

  before do
    @product_range = mock_model(Product_range, :destroy => true)
    Product_range.stub!(:find).and_return(@product_range)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the product_range requested" do
    Product_range.should_receive(:find).with("1").and_return(@product_range)
    do_delete
  end
  
  it "should call destroy on the found product_range" do
    @product_range.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the product_ranges list" do
    do_delete
    response.should redirect_to(product_ranges_url)
  end
end
