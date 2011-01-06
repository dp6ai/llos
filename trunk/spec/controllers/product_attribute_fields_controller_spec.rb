require File.dirname(__FILE__) + '/../spec_helper'

describe ProductAttributeFieldsController, "#route_for" do

  it "should map { :controller => 'product_attribute_fields', :action => 'index' } to /product_attribute_fields" do
    route_for(:controller => "product_attribute_fields", :action => "index").should == "/product_attribute_fields"
  end
  
  it "should map { :controller => 'product_attribute_fields', :action => 'new' } to /product_attribute_fields/new" do
    route_for(:controller => "product_attribute_fields", :action => "new").should == "/product_attribute_fields/new"
  end
  
  it "should map { :controller => 'product_attribute_fields', :action => 'show', :id => 1 } to /product_attribute_fields/1" do
    route_for(:controller => "product_attribute_fields", :action => "show", :id => 1).should == "/product_attribute_fields/1"
  end
  
  it "should map { :controller => 'product_attribute_fields', :action => 'edit', :id => 1 } to /product_attribute_fields/1/edit" do
    route_for(:controller => "product_attribute_fields", :action => "edit", :id => 1).should == "/product_attribute_fields/1/edit"
  end
  
  it "should map { :controller => 'product_attribute_fields', :action => 'update', :id => 1} to /product_attribute_fields/1" do
    route_for(:controller => "product_attribute_fields", :action => "update", :id => 1).should == "/product_attribute_fields/1"
  end
  
  it "should map { :controller => 'product_attribute_fields', :action => 'destroy', :id => 1} to /product_attribute_fields/1" do
    route_for(:controller => "product_attribute_fields", :action => "destroy", :id => 1).should == "/product_attribute_fields/1"
  end
  
end

describe ProductAttributeFieldsController, "handling GET /product_attribute_fields" do

  before do
    @product_attribute_fields = mock_model(Product_attribute_fields)
    Product_attribute_fields.stub!(:find).and_return([@product_attribute_fields])
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
  
  it "should find all product_attribute_fields" do
    Product_attribute_fields.should_receive(:find).with(:all).and_return([@product_attribute_fields])
    do_get
  end
  
  it "should assign the found product_attribute_fields for the view" do
    do_get
    assigns[:product_attribute_fields].should == [@product_attribute_fields]
  end
end

describe ProductAttributeFieldsController, "handling GET /product_attribute_fields.xml" do

  before do
    @product_attribute_fields = mock_model(Product_attribute_fields, :to_xml => "XML")
    Product_attribute_fields.stub!(:find).and_return(@product_attribute_fields)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all product_attribute_fields" do
    Product_attribute_fields.should_receive(:find).with(:all).and_return([@product_attribute_fields])
    do_get
  end
  
  it "should render the found product_attribute_fields as xml" do
    @product_attribute_fields.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ProductAttributeFieldsController, "handling GET /product_attribute_fields/1" do

  before do
    @product_attribute_fields = mock_model(Product_attribute_fields)
    Product_attribute_fields.stub!(:find).and_return(@product_attribute_fields)
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
  
  it "should find the product_attribute_fields requested" do
    Product_attribute_fields.should_receive(:find).with("1").and_return(@product_attribute_fields)
    do_get
  end
  
  it "should assign the found product_attribute_fields for the view" do
    do_get
    assigns[:product_attribute_fields].should equal(@product_attribute_fields)
  end
end

describe ProductAttributeFieldsController, "handling GET /product_attribute_fields/1.xml" do

  before do
    @product_attribute_fields = mock_model(Product_attribute_fields, :to_xml => "XML")
    Product_attribute_fields.stub!(:find).and_return(@product_attribute_fields)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the product_attribute_fields requested" do
    Product_attribute_fields.should_receive(:find).with("1").and_return(@product_attribute_fields)
    do_get
  end
  
  it "should render the found product_attribute_fields as xml" do
    @product_attribute_fields.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ProductAttributeFieldsController, "handling GET /product_attribute_fields/new" do

  before do
    @product_attribute_fields = mock_model(Product_attribute_fields)
    Product_attribute_fields.stub!(:new).and_return(@product_attribute_fields)
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
  
  it "should create an new product_attribute_fields" do
    Product_attribute_fields.should_receive(:new).and_return(@product_attribute_fields)
    do_get
  end
  
  it "should not save the new product_attribute_fields" do
    @product_attribute_fields.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new product_attribute_fields for the view" do
    do_get
    assigns[:product_attribute_fields].should equal(@product_attribute_fields)
  end
end

describe ProductAttributeFieldsController, "handling GET /product_attribute_fields/1/edit" do

  before do
    @product_attribute_fields = mock_model(Product_attribute_fields)
    Product_attribute_fields.stub!(:find).and_return(@product_attribute_fields)
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
  
  it "should find the product_attribute_fields requested" do
    Product_attribute_fields.should_receive(:find).and_return(@product_attribute_fields)
    do_get
  end
  
  it "should assign the found product_attribute_fields for the view" do
    do_get
    assigns[:product_attribute_fields].should equal(@product_attribute_fields)
  end
end

describe ProductAttributeFieldsController, "handling POST /product_attribute_fields" do

  before do
    @product_attribute_fields = mock_model(Product_attribute_fields, :to_param => "1")
    Product_attribute_fields.stub!(:new).and_return(@product_attribute_fields)
  end
  
  def post_with_successful_save
    @product_attribute_fields.should_receive(:save).and_return(true)
    post :create, :product_attribute_fields => {}
  end
  
  def post_with_failed_save
    @product_attribute_fields.should_receive(:save).and_return(false)
    post :create, :product_attribute_fields => {}
  end
  
  it "should create a new product_attribute_fields" do
    Product_attribute_fields.should_receive(:new).with({}).and_return(@product_attribute_fields)
    post_with_successful_save
  end

  it "should redirect to the new product_attribute_fields on successful save" do
    post_with_successful_save
    response.should redirect_to(product_attribute_field_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe ProductAttributeFieldsController, "handling PUT /product_attribute_fields/1" do

  before do
    @product_attribute_fields = mock_model(Product_attribute_fields, :to_param => "1")
    Product_attribute_fields.stub!(:find).and_return(@product_attribute_fields)
  end
  
  def put_with_successful_update
    @product_attribute_fields.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @product_attribute_fields.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the product_attribute_fields requested" do
    Product_attribute_fields.should_receive(:find).with("1").and_return(@product_attribute_fields)
    put_with_successful_update
  end

  it "should update the found product_attribute_fields" do
    put_with_successful_update
    assigns(:product_attribute_fields).should equal(@product_attribute_fields)
  end

  it "should assign the found product_attribute_fields for the view" do
    put_with_successful_update
    assigns(:product_attribute_fields).should equal(@product_attribute_fields)
  end

  it "should redirect to the product_attribute_fields on successful update" do
    put_with_successful_update
    response.should redirect_to(product_attribute_field_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe ProductAttributeFieldsController, "handling DELETE /product_attribute_fields/1" do

  before do
    @product_attribute_fields = mock_model(Product_attribute_fields, :destroy => true)
    Product_attribute_fields.stub!(:find).and_return(@product_attribute_fields)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the product_attribute_fields requested" do
    Product_attribute_fields.should_receive(:find).with("1").and_return(@product_attribute_fields)
    do_delete
  end
  
  it "should call destroy on the found product_attribute_fields" do
    @product_attribute_fields.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the product_attribute_fields list" do
    do_delete
    response.should redirect_to(product_attribute_fields_url)
  end
end
