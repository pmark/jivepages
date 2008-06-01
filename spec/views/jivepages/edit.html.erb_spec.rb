require File.dirname(__FILE__) + '/../../spec_helper'

describe "/jivepages/edit.html.erb" do
  include JivepagesHelper
  
  before do
    @jivepage = mock_model(Jivepage)
    @jivepage.stub!(:owner_id).and_return("1")
    @jivepage.stub!(:title).and_return("MyString")
    assigns[:jivepage] = @jivepage
  end

  it "should render edit form" do
    render "/jivepages/edit.html.erb"
    
    response.should have_tag("form[action=#{jivepage_path(@jivepage)}][method=post]") do
      with_tag('input#jivepage_title[name=?]', "jivepage[title]")
    end
  end
end


