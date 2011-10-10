class Admin::AssetsController < ApplicationController

  before_filter :login_required
  layout "admin"

  # GET /asset
  # GET /asset.xml
  def index
    @assets = Asset.all.paginate :page => params[:page], :per_page => 30

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @assets }
    end
  end

  # GET /asset/1
  # GET /asset/1.xml
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @asset }
    end
  end

  # GET /asset/new
  # GET /asset/new.xml
  def new
    @asset = Asset.new
    assign_lovs

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @asset }
    end
  end

  # GET /asset/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST /asset
  # POST /asset.xml
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        flash[:notice] = 'Asset was successfully created.'
        format.html { redirect_to(admin_asset_path(@asset)) }
        format.xml  { render :xml => @asset, :status => :created, :location => @asset }
      else
        assign_lovs
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /asset/1
  # PUT /asset/1.xml
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        flash[:notice] = 'Asset was successfully updated.'
        format.html { redirect_to(admin_asset_path(@asset)) }
        format.xml  { head :ok }
      else
        assign_lovs
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /asset/1
  # DELETE /asset/1.xml
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to(admin_assets_url) }
      format.xml  { head :ok }
    end
  end
end
