require File.dirname(__FILE__) + '/../../spec_helper'

describe "/page_changes/show.html.erb" do
  include PageChangesHelper
  
  before(:each) do
    @page_change = mock_model(PageChange)
    @page_change.stub!(:edit_session_id).and_return("1")
    @page_change.stub!(:content).and_return("MyText")
    @page_change.stub!(:marker_element_id).and_return("MyString")

    assigns[:page_change] = @page_change
  end

  it "should render attributes in <p>" do
    render "/page_changes/show.html.erb"
    response.should have_text(/MyText/)
  end
end

