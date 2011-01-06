require File.dirname(__FILE__) + '/../../spec_helper'

describe "/project/edit.haml" do
  include ProjectsHelper
  
  before do
    @project = mock_model(Project)
    @project.stub!(:title).and_return("MyString")
    @project.stub!(:description).and_return("MyText")
    assigns[:project] = @project
  end

  it "should render edit form" do
    render "/projects/edit.haml"
    
    response.should have_tag("form[action=#{project_path(@project)}][method=post]") do
      with_tag('input#project_title[name=?]', "project[title]")
      with_tag('textarea#project_description[name=?]', "project[description]")
    end
  end
end