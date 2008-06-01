require File.dirname(__FILE__) + '/../../spec_helper'

describe "/boxes/new.html.erb" do
  include BoxesHelper
  
  before(:each) do
    @box = mock_model(Box)
    @box.stub!(:new_record?).and_return(true)
    @box.stub!(:jivepage_id).and_return("1")
    @box.stub!(:cell_id).and_return("1")
    @box.stub!(:content).and_return("MyText")
    @box.stub!(:position).and_return("1")
    assigns[:box] = @box
  end

  it "should render new form" do
    render "/boxes/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", boxes_path) do
      with_tag("textarea#box_content[name=?]", "box[content]")
      with_tag("input#box_position[name=?]", "box[position]")
    end
  end
end


