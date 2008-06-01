require File.dirname(__FILE__) + '/../../spec_helper'

describe "/cells/index.html.erb" do
  include CellsHelper
  
  before(:each) do
    cell_98 = mock_model(Cell)
    cell_98.should_receive(:box_id).and_return("1")
    cell_98.should_receive(:size).and_return("MyString")
    cell_98.should_receive(:full_content).and_return("MyText")
    cell_98.should_receive(:position).and_return("1")
    cell_99 = mock_model(Cell)
    cell_99.should_receive(:box_id).and_return("1")
    cell_99.should_receive(:size).and_return("MyString")
    cell_99.should_receive(:full_content).and_return("MyText")
    cell_99.should_receive(:position).and_return("1")

    assigns[:cells] = [cell_98, cell_99]
  end

  it "should render list of cells" do
    render "/cells/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

