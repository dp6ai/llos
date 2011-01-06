class Admin::ProductAttributeFieldsController < ApplicationController

  before_filter :login_required
  
  layout "admin"

  # GET /product_attribute_fields
  # GET /product_attribute_fields.xml
  def index
    @product_attribute_fields = ProductAttributeField.find(:all)

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @product_attribute_fields }
    end
  end

  # GET /product_attribute_fields/1
  # GET /product_attribute_fields/1.xml
  def show
    @product_attribute_field = ProductAttributeField.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @product_attribute_field }
    end
  end

  # GET /product_attribute_fields/new
  # GET /product_attribute_fields/new.xml
  def new
    @product_attribute_field = ProductAttributeField.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @product_attribute_field }
    end
  end

  # GET /product_attribute_fields/1/edit
  def edit
    @product_attribute_field = ProductAttributeField.find(params[:id])
  end

  # POST /product_attribute_fields
  # POST /product_attribute_fields.xml
  def create
    @product_attribute_field = ProductAttributeField.new(params[:product_attribute_field])

    respond_to do |format|
      if @product_attribute_field.save
        flash[:notice] = 'Product_attribute_fields was successfully created.'
        format.html { redirect_to(admin_product_attribute_field_path(@product_attribute_field)) }
        format.xml  { render :xml => @product_attribute_field, :status => :created, :location => @product_attribute_field }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_attribute_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_attribute_fields/1
  # PUT /product_attribute_fields/1.xml
  def update
    @product_attribute_field = ProductAttributeField.find(params[:id])

    respond_to do |format|
      if @product_attribute_field.update_attributes(params[:product_attribute_field])
        flash[:notice] = 'Product_attribute_fields was successfully updated.'
        format.html { redirect_to(admin_product_attribute_field_path(@product_attribute_field)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_attribute_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_attribute_fields/1
  # DELETE /product_attribute_fields/1.xml
  def destroy
    @product_attribute_field = ProductAttributeField.find(params[:id])
    @product_attribute_field.destroy

    respond_to do |format|
      format.html { redirect_to(admin_product_attribute_fields_url) }
      format.xml  { head :ok }
    end
  end
end
