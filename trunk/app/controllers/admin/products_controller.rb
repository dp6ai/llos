class Admin::ProductsController < ApplicationController

  before_filter :login_required
  layout "admin"

  # GET /product
  # GET /product.xml
  def index
    @products = Product.all_by_code.paginate :page => params[:page], :per_page => 30

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @products }
    end
  end

  # GET /product/1
  # GET /product/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @product }
    end
  end

  # GET /product/new
  # GET /product/new.xml
  def new
    @product = Product.new
    assign_lovs

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @product }
    end
  end

  # GET /product/1/edit
  def edit
    @product = Product.find(params[:id])
    assign_lovs
  end

  # POST /product
  # POST /product.xml
  def create
    @product = Product.new(params[:product])

    collect_and_assign_product_attributes
    collect_and_assign_new_categories

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to(admin_product_path(@product)) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        assign_lovs
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product/1
  # PUT /product/1.xml
  def update
    @product = Product.find(params[:id])

    collect_and_assign_product_weaves
    collect_and_assign_product_fabrics
    collect_and_assign_product_attributes
    collect_and_assign_new_categories
    
    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(admin_product_path(@product)) }
        format.xml  { head :ok }
      else
        assign_lovs
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product/1
  # DELETE /product/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end

  private
  
  def collect_and_assign_new_categories
    old_type_tags = old_room_tags = old_outdoor_tags = []
    new_type_tags= new_room_tags= new_outdoor_tags = []

    old_type_tags = Tag.find(params[:type_ids]).collect{|t| t.name } if params[:type_ids]
    new_type_tags = params[:type_list].split(",") if params[:type_list]

    old_room_tags = Tag.find(params[:room_ids]).collect{|t| t.name } if params[:room_ids]
    new_room_tags = params[:room_list].split(",") if params[:room_list]

    old_outdoor_tags = Tag.find(params[:outdoor_ids]).collect{|t| t.name } if params[:outdoor_ids]
    new_outdoor_tags = params[:outdoor_list].split(",") if params[:outdoor_list]

    @product.type_list = (old_type_tags + new_type_tags).join(",")
    @product.room_list = (old_room_tags + new_room_tags).join(",")
    @product.outdoor_list = (old_outdoor_tags + new_outdoor_tags).join(",")

  end

  def collect_and_assign_product_attributes
    # yikes, horrid, surely rails can do all this for us?
    if !params[:product_attributes].blank?
      pas = []
      params[:product_attributes].each do |_pa|
        pa = ProductAttribute.find_by_product_id_and_product_attribute_field_id(@product.id, _pa[0])
        if pa
          if _pa[1].strip.blank?
            pa.destroy
          else
            pa.value = _pa[1]
            pa.save!
          end
        else
          pa = ProductAttribute.new(:product_attribute_field_id =>_pa[0], :value => _pa[1]) if !_pa[1].strip.blank?
        end
        pas << pa if !_pa[1].strip.blank?
      end

      @product.product_attributes = pas
    end
  end

  def collect_and_assign_product_weaves
    wes = []
    if !params[:weaves].blank?
      params[:weaves].each do |_we|
        we = ProductWeave.new(:weave_id =>_we[0])
        wes << we
      end

      @product.product_weaves = wes
    end
  end

  def collect_and_assign_product_fabrics
    fabs = []
    if !params[:fabrics].blank?
      params[:fabrics].each do |_fa|
        fa = ProductFabric.new(:fabric_id =>_fa[0])
        fabs << fa
      end
    end
    @product.product_fabrics = fabs
  end
end
