require File.dirname(__FILE__) + '/../../spec_helper'

describe "/page_changes/index.html.erb" do
  include PageChangesHelper
  
  before(:each) do
    page_change_98 = mock_model(PageChange)
    page_change_98.should_receive(:edit_session_id).and_return("1")
    page_change_98.should_receive(:content).and_return("MyText")
    page_change_98.should_receive(:marker_element_id).and_return("MyString")
    page_change_99 = mock_model(PageChange)
    page_change_99.should_receive(:edit_session_id).and_return("1")
    page_change_99.should_receive(:content).and_return("MyText")
    page_change_99.should_receive(:marker_element_id).and_return("MyString")

    assigns[:page_changes] = [page_change_98, page_change_99]
  end

  it "should render list of page_changes" do
    render "/page_changes/index.html.erb"
    response.should have_tag("tr>td", "MyText", 2)
  end
end

