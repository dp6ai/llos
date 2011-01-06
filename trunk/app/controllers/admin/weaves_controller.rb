class Admin::WeavesController < ApplicationController

  layout "admin"
  before_filter :login_required
  
  # GET /weave
  # GET /weave.xml
  def index
    @weaves = Weave.all_asc

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @weaves }
    end
  end

  # GET /weave/1
  # GET /weave/1.xml
  def show
    @weave = Weave.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @weave }
    end
  end

  # GET /weave/new
  # GET /weave/new.xml
  def new
    @weave = Weave.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @weave }
    end
  end

  # GET /weave/1/edit
  def edit
    @weave = Weave.find(params[:id])
  end

  # POST /weave
  # POST /weave.xml
  def create
    @weave = Weave.new(params[:weave])

    respond_to do |format|
      if @weave.save
        flash[:notice] = 'weave was successfully created.'
        format.html { redirect_to(admin_weave_path(@weave)) }
        format.xml  { render :xml => @weave, :status => :created, :location => @weave }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weave.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weave/1
  # PUT /weave/1.xml
  def update
    @weave = Weave.find(params[:id])

    respond_to do |format|
      if @weave.update_attributes(params[:weave])
        flash[:notice] = 'weave was successfully updated.'
        format.html { redirect_to(admin_weave_path(@weave)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weave.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weave/1
  # DELETE /weave/1.xml
  def destroy
    @weave = Weave.find(params[:id])
    @weave.destroy

    respond_to do |format|
      format.html { redirect_to(admin_weaves_url) }
      format.xml  { head :ok }
    end
  end
end
