class Admin::ProductRangesController < ApplicationController

  before_filter :login_required
  layout "admin"

  # GET /product_range
  # GET /product_range.xml
  def index
    @product_ranges = ProductRange.find(:all)

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @product_ranges }
    end
  end

  # GET /product_range/1
  # GET /product_range/1.xml
  def show
    @product_range = ProductRange.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @product_range }
    end
  end

  # GET /product_range/new
  # GET /product_range/new.xml
  def new
    @product_range = ProductRange.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @product_range }
    end
  end

  # GET /product_range/1/edit
  def edit
    @product_range = ProductRange.find(params[:id])
  end

  # POST /product_range
  # POST /product_range.xml
  def create
    @product_range = ProductRange.new(params[:product_range])

    respond_to do |format|
      if @product_range.save
        flash[:notice] = 'Product_range was successfully created.'
        format.html { redirect_to(admin_product_range_path(@product_range)) }
        format.xml  { render :xml => @product_range, :status => :created, :location => @product_range }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_range.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_range/1
  # PUT /product_range/1.xml
  def update
    @product_range = ProductRange.find(params[:id])

    respond_to do |format|
      if @product_range.update_attributes(params[:product_range])
        flash[:notice] = 'Product_range was successfully updated.'
        format.html { redirect_to(admin_product_range_path(@product_range)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_range.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_range/1
  # DELETE /product_range/1.xml
  def destroy
    @product_range = ProductRange.find(params[:id])
    @product_range.destroy

    respond_to do |format|
      format.html { redirect_to(admin_product_ranges_url) }
      format.xml  { head :ok }
    end
  end
end
