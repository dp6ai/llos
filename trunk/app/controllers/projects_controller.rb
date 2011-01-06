class ProjectsController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]

  # GET /project
  # GET /project.xml
  def index
    @projects = Project.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 6

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @projects }
    end
  end

  # GET /project/1
  # GET /project/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @project }
    end
  end

  # GET /project/new
  # GET /project/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @project }
    end
  end

  # GET /project/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /project
  # POST /project.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(project_path(@project)) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /project/1
  # PUT /project/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(project_path(@project)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project/1
  # DELETE /project/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
