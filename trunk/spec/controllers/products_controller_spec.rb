require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController, "#route_for" do

  it "should map { :controller => 'products', :action => 'index' } to /products" do
    route_for(:controller => "products", :action => "index").should == "/products"
  end
  
  it "should map { :controller => 'products', :action => 'new' } to /products/new" do
    route_for(:controller => "products", :action => "new").should == "/products/new"
  end
  
  it "should map { :controller => 'products', :action => 'show', :id => 1 } to /products/1" do
    route_for(:controller => "products", :action => "show", :id => 1).should == "/products/1"
  end
  
  it "should map { :controller => 'products', :action => 'edit', :id => 1 } to /products/1/edit" do
    route_for(:controller => "products", :action => "edit", :id => 1).should == "/products/1/edit"
  end
  
  it "should map { :controller => 'products', :action => 'update', :id => 1} to /products/1" do
    route_for(:controller => "products", :action => "update", :id => 1).should == "/products/1"
  end
  
  it "should map { :controller => 'products', :action => 'destroy', :id => 1} to /products/1" do
    route_for(:controller => "products", :action => "destroy", :id => 1).should == "/products/1"
  end
  
end

describe ProductsController, "handling GET /products" do

  before do
    @product = mock_model(Product)
    Product.stub!(:find).and_return([@product])
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
  
  it "should find all products" do
    Product.should_receive(:find).with(:all).and_return([@product])
    do_get
  end
  
  it "should assign the found products for the view" do
    do_get
    assigns[:products].should == [@product]
  end
end

describe ProductsController, "handling GET /products.xml" do

  before do
    @product = mock_model(Product, :to_xml => "XML")
    Product.stub!(:find).and_return(@product)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all products" do
    Product.should_receive(:find).with(:all).and_return([@product])
    do_get
  end
  
  it "should render the found product as xml" do
    @product.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ProductsController, "handling GET /products/1" do

  before do
    @product = mock_model(Product)
    Product.stub!(:find).and_return(@product)
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
  
  it "should find the product requested" do
    Product.should_receive(:find).with("1").and_return(@product)
    do_get
  end
  
  it "should assign the found product for the view" do
    do_get
    assigns[:product].should equal(@product)
  end
end

describe ProductsController, "handling GET /products/1.xml" do

  before do
    @product = mock_model(Product, :to_xml => "XML")
    Product.stub!(:find).and_return(@product)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the product requested" do
    Product.should_receive(:find).with("1").and_return(@product)
    do_get
  end
  
  it "should render the found product as xml" do
    @product.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ProductsController, "handling GET /products/new" do

  before do
    @product = mock_model(Product)
    Product.stub!(:new).and_return(@product)
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
  
  it "should create an new product" do
    Product.should_receive(:new).and_return(@product)
    do_get
  end
  
  it "should not save the new product" do
    @product.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new product for the view" do
    do_get
    assigns[:product].should equal(@product)
  end
end

describe ProductsController, "handling GET /products/1/edit" do

  before do
    @product = mock_model(Product)
    Product.stub!(:find).and_return(@product)
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
  
  it "should find the product requested" do
    Product.should_receive(:find).and_return(@product)
    do_get
  end
  
  it "should assign the found product for the view" do
    do_get
    assigns[:product].should equal(@product)
  end
end

describe ProductsController, "handling POST /products" do

  before do
    @product = mock_model(Product, :to_param => "1")
    Product.stub!(:new).and_return(@product)
  end
  
  def post_with_successful_save
    @product.should_receive(:save).and_return(true)
    post :create, :product => {}
  end
  
  def post_with_failed_save
    @product.should_receive(:save).and_return(false)
    post :create, :product => {}
  end
  
  it "should create a new product" do
    Product.should_receive(:new).with({}).and_return(@product)
    post_with_successful_save
  end

  it "should redirect to the new product on successful save" do
    post_with_successful_save
    response.should redirect_to(product_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe ProductsController, "handling PUT /products/1" do

  before do
    @product = mock_model(Product, :to_param => "1")
    Product.stub!(:find).and_return(@product)
  end
  
  def put_with_successful_update
    @product.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @product.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the product requested" do
    Product.should_receive(:find).with("1").and_return(@product)
    put_with_successful_update
  end

  it "should update the found product" do
    put_with_successful_update
    assigns(:product).should equal(@product)
  end

  it "should assign the found product for the view" do
    put_with_successful_update
    assigns(:product).should equal(@product)
  end

  it "should redirect to the product on successful update" do
    put_with_successful_update
    response.should redirect_to(product_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe ProductsController, "handling DELETE /product/1" do

  before do
    @product = mock_model(Product, :destroy => true)
    Product.stub!(:find).and_return(@product)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the product requested" do
    Product.should_receive(:find).with("1").and_return(@product)
    do_delete
  end
  
  it "should call destroy on the found product" do
    @product.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the products list" do
    do_delete
    response.should redirect_to(products_url)
  end
end
