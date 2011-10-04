class Admin::StockistsController < ApplicationController

  before_filter :login_required
  layout "admin"

  # GET /stockist
  # GET /stockist.xml
  def index
    @stockists = Stockist.all.paginate :page => params[:page], :per_page => 30

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @stockists }
    end
  end

  # GET /stockist/1
  # GET /stockist/1.xml
  def show
    @stockist = Stockist.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @stockist }
    end
  end

  # GET /stockist/new
  # GET /stockist/new.xml
  def new
    @stockist = Stockist.new
    assign_lovs

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @stockist }
    end
  end

  # GET /stockist/1/edit
  def edit
    @stockist = Stockist.find(params[:id])
  end

  # POST /stockist
  # POST /stockist.xml
  def create
    @stockist = Stockist.new(params[:stockist])

    respond_to do |format|
      if @stockist.save
        flash[:notice] = 'Stockist was successfully created.'
        format.html { redirect_to(admin_stockist_path(@stockist)) }
        format.xml  { render :xml => @stockist, :status => :created, :location => @stockist }
      else
        assign_lovs
        format.html { render :action => "new" }
        format.xml  { render :xml => @stockist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stockist/1
  # PUT /stockist/1.xml
  def update
    @stockist = Stockist.find(params[:id])

    respond_to do |format|
      if @stockist.update_attributes(params[:stockist])
        flash[:notice] = 'Stockist was successfully updated.'
        format.html { redirect_to(admin_stockist_path(@stockist)) }
        format.xml  { head :ok }
      else
        assign_lovs
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stockist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stockist/1
  # DELETE /stockist/1.xml
  def destroy
    @stockist = Stockist.find(params[:id])
    @stockist.destroy

    respond_to do |format|
      format.html { redirect_to(stockists_url) }
      format.xml  { head :ok }
    end
  end
end
