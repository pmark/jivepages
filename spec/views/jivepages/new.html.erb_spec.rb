require File.dirname(__FILE__) + '/../../spec_helper'

describe "/jivepages/new.html.erb" do
  include JivepagesHelper
  
  before(:each) do
    @jivepage = mock_model(Jivepage)
    @jivepage.stub!(:new_record?).and_return(true)
    @jivepage.stub!(:owner_id).and_return("1")
    @jivepage.stub!(:title).and_return("MyString")
    assigns[:jivepage] = @jivepage
  end

  it "should render new form" do
    render "/jivepages/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", jivepages_path) do
      with_tag("input#jivepage_title[name=?]", "jivepage[title]")
    end
  end
end


