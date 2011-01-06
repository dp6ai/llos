require File.dirname(__FILE__) + '/../../spec_helper'

describe "/projects/new.haml" do
  include ProjectsHelper
  
  before do
    @project = mock_model(Project)
    @project.stub!(:new_record?).and_return(true)
    @project.stub!(:title).and_return("MyString")
    @project.stub!(:description).and_return("MyText")
    assigns[:project] = @project
  end

  it "should render new form" do
    render "/projects/new.haml"
    
    response.should have_tag("form[action=?][method=post]", projects_path) do
      with_tag("input#project_title[name=?]", "project[title]")
      with_tag("textarea#project_description[name=?]", "project[description]")
    end
  end
end
