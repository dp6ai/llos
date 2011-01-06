require File.dirname(__FILE__) + '/../../spec_helper'

describe "/projects/index.haml" do
  include ProjectsHelper
  
  before do
    project_98 = mock_model(Project)
    project_98.should_receive(:title).and_return("MyString")
    project_98.should_receive(:description).and_return("MyText")
    project_99 = mock_model(Project)
    project_99.should_receive(:title).and_return("MyString")
    project_99.should_receive(:description).and_return("MyText")

    assigns[:projects] = [project_98, project_99]
  end

  it "should render list of projects" do
    render "/projects/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end
