require File.dirname(__FILE__) + '/../../spec_helper'

describe "/cells/edit.html.erb" do
  include CellsHelper
  
  before do
    @cell = mock_model(Cell)
    @cell.stub!(:box_id).and_return("1")
    @cell.stub!(:size).and_return("MyString")
    @cell.stub!(:full_content).and_return("MyText")
    @cell.stub!(:position).and_return("1")
    assigns[:cell] = @cell
  end

  it "should render edit form" do
    render "/cells/edit.html.erb"
    
    response.should have_tag("form[action=#{cell_path(@cell)}][method=post]") do
      with_tag('input#cell_size[name=?]', "cell[size]")
      with_tag('textarea#cell_full_content[name=?]', "cell[full_content]")
      with_tag('input#cell_position[name=?]', "cell[position]")
    end
  end
end


