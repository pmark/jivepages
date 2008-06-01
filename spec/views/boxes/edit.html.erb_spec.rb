require File.dirname(__FILE__) + '/../../spec_helper'

describe "/boxes/edit.html.erb" do
  include BoxesHelper
  
  before do
    @box = mock_model(Box)
    @box.stub!(:jivepage_id).and_return("1")
    @box.stub!(:cell_id).and_return("1")
    @box.stub!(:content).and_return("MyText")
    @box.stub!(:position).and_return("1")
    assigns[:box] = @box
  end

  it "should render edit form" do
    render "/boxes/edit.html.erb"
    
    response.should have_tag("form[action=#{box_path(@box)}][method=post]") do
      with_tag('textarea#box_content[name=?]', "box[content]")
      with_tag('input#box_position[name=?]', "box[position]")
    end
  end
end


