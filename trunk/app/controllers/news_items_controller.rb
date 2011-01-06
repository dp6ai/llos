class NewsItemsController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  # GET /news_item
  # GET /news_item.xml
  def index
    @news_items = NewsItem.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 4

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @news_items }
    end
  end

  # GET /news_item/1
  # GET /news_item/1.xml
  def show
    @news_item = NewsItem.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @news_item }
    end
  end

  # GET /news_item/new
  # GET /news_item/new.xml
  def new
    @news_item = NewsItem.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @news_item }
    end
  end

  # GET /news_item/1/edit
  def edit
    @news_item = NewsItem.find(params[:id])
  end

  # POST /news_item
  # POST /news_item.xml
  def create
    @news_item = NewsItem.new(params[:news_item])

    respond_to do |format|
      if @news_item.save
        flash[:notice] = 'News item was successfully created.'
        format.html { redirect_to(news_path(@news_item)) }
        format.xml  { render :xml => @news_item, :status => :created, :location => @news_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /news_item/1
  # PUT /news_item/1.xml
  def update
    @news_item = NewsItem.find(params[:id])

    respond_to do |format|
      if @news_item.update_attributes(params[:news_item])
        flash[:notice] = 'News item was successfully updated.'
        format.html { redirect_to(news_path(@news_item)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @news_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /news_item/1
  # DELETE /news_item/1.xml
  def destroy
    @news_item = NewsItem.find(params[:id])
    @news_item.destroy

    respond_to do |format|
      format.html { redirect_to(news_items_url) }
      format.xml  { head :ok }
    end
  end
end
