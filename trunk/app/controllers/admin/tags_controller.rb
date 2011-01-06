class Admin::TagsController < ApplicationController

  layout "admin"
  before_filter :login_required
  
  # GET /tag
  # GET /tag.xml
  def index
    @categories = Tag.all_asc_by_kind :include => {:taggings => :taggable}

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @tags }
    end
  end

  # GET /tag/1
  # GET /tag/1.xml
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tag/new
  # GET /tag/new.xml
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tag/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tag
  # POST /tag.xml
  def create
    @tag = Tag.new(params[:tag])
    @tag.kind.downcase!

    respond_to do |format|
      if @tag.save
        flash[:notice] = 'tag was successfully created.'
        format.html { redirect_to(admin_category_path(@tag)) }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tag/1
  # PUT /tag/1.xml
  def update
    @tag = Tag.find(params[:id])
    params[:tag][:kind].downcase!

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'tag was successfully updated.'
        format.html { redirect_to(admin_category_path(@tag)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tag/1
  # DELETE /tag/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(admin_categories_url) }
      format.xml  { head :ok }
    end
  end
end
