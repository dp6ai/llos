class Admin::TaggingsController < ApplicationController

  layout "admin"
  before_filter :login_required
  
  # GET /tagging/1
  # GET /tagging/1.xml
  def show
    @tagging = Tagging.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @tagging }
    end
  end

  # GET /tagging/new
  # GET /tagging/new.xml
  def new
    @tagging = Tagging.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @tagging }
    end
  end

  # GET /tagging/1/edit
  def edit
    @tagging = Tagging.find(params[:id])

  end

  # PUT /tagging/1
  # PUT /tagging/1.xml
  def update
    @tagging = Tagging.find(params[:id])

    respond_to do |format|
      if @tagging.update_attributes(params[:tagging])
        flash[:notice] = 'Tagging was successfully updated.'
        format.html { redirect_to(admin_tagging_path(@tagging)) }
        format.xml  { head :ok }
      else

        format.html { render :action => "edit" }
        format.xml  { render :xml => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tagging/1
  # DELETE /tagging/1.xml
  def destroy
    @tagging = Tagging.find(params[:id])
    @tagging.destroy

    respond_to do |format|
      format.html { redirect_to(admin_taggings_url) }
      format.xml  { head :ok }
    end
  end

end
