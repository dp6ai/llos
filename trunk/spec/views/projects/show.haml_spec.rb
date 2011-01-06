require File.dirname(__FILE__) + '/../../spec_helper'

describe "/projects/show.haml" do
  include ProjectsHelper
  
  before do
    @project = mock_model(Project)
    @project.stub!(:title).and_return("MyString")
    @project.stub!(:description).and_return("MyText")

    assigns[:project] = @project
  end

  it "should render attributes in <p>" do
    render "/projects/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

