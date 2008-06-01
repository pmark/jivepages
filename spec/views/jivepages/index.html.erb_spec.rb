require File.dirname(__FILE__) + '/../../spec_helper'

describe "/jivepages/index.html.erb" do
  include JivepagesHelper
  
  before(:each) do
    jivepage_98 = mock_model(Jivepage)
    jivepage_98.should_receive(:owner_id).and_return("1")
    jivepage_98.should_receive(:title).and_return("MyString")
    jivepage_99 = mock_model(Jivepage)
    jivepage_99.should_receive(:owner_id).and_return("1")
    jivepage_99.should_receive(:title).and_return("MyString")

    assigns[:jivepages] = [jivepage_98, jivepage_99]
  end

  it "should render list of jivepages" do
    render "/jivepages/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

