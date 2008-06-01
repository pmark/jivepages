require File.dirname(__FILE__) + '/../../spec_helper'

describe "/page_changes/edit.html.erb" do
  include PageChangesHelper
  
  before do
    @page_change = mock_model(PageChange)
    @page_change.stub!(:edit_session_id).and_return("1")
    @page_change.stub!(:content).and_return("MyText")
    @page_change.stub!(:marker_element_id).and_return("MyString")
    assigns[:page_change] = @page_change
  end

  it "should render edit form" do
    render "/page_changes/edit.html.erb"
    
    response.should have_tag("form[action=#{page_change_path(@page_change)}][method=post]") do
      with_tag('textarea#page_change_content[name=?]', "page_change[content]")
    end
  end
end


