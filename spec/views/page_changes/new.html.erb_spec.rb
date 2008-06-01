require File.dirname(__FILE__) + '/../../spec_helper'

describe "/page_changes/new.html.erb" do
  include PageChangesHelper
  
  before(:each) do
    @page_change = mock_model(PageChange)
    @page_change.stub!(:new_record?).and_return(true)
    @page_change.stub!(:edit_session_id).and_return("1")
    @page_change.stub!(:content).and_return("MyText")
    @page_change.stub!(:marker_element_id).and_return("MyString")
    assigns[:page_change] = @page_change
  end

  it "should render new form" do
    render "/page_changes/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", page_changes_path) do
      with_tag("textarea#page_change_content[name=?]", "page_change[content]")
    end
  end
end


