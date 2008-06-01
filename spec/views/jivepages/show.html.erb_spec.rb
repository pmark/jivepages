require File.dirname(__FILE__) + '/../../spec_helper'

describe "/jivepages/show.html.erb" do
  include JivepagesHelper
  
  before(:each) do
    @jivepage = mock_model(Jivepage)
    @jivepage.stub!(:owner_id).and_return("1")
    @jivepage.stub!(:title).and_return("MyString")

    assigns[:jivepage] = @jivepage
  end

  it "should render attributes in <p>" do
    render "/jivepages/show.html.erb"
    response.should have_text(/MyString/)
  end
end

