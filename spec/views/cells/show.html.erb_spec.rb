require File.dirname(__FILE__) + '/../../spec_helper'

describe "/cells/show.html.erb" do
  include CellsHelper
  
  before(:each) do
    @cell = mock_model(Cell)
    @cell.stub!(:box_id).and_return("1")
    @cell.stub!(:size).and_return("MyString")
    @cell.stub!(:full_content).and_return("MyText")
    @cell.stub!(:position).and_return("1")

    assigns[:cell] = @cell
  end

  it "should render attributes in <p>" do
    render "/cells/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
    response.should have_text(/1/)
  end
end

