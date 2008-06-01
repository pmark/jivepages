require File.dirname(__FILE__) + '/../../spec_helper'

describe "/boxes/index.html.erb" do
  include BoxesHelper
  
  before(:each) do
    box_98 = mock_model(Box)
    box_98.should_receive(:jivepage_id).and_return("1")
    box_98.should_receive(:cell_id).and_return("1")
    box_98.should_receive(:content).and_return("MyText")
    box_98.should_receive(:position).and_return("1")
    box_99 = mock_model(Box)
    box_99.should_receive(:jivepage_id).and_return("1")
    box_99.should_receive(:cell_id).and_return("1")
    box_99.should_receive(:content).and_return("MyText")
    box_99.should_receive(:position).and_return("1")

    assigns[:boxes] = [box_98, box_99]
  end

  it "should render list of boxes" do
    render "/boxes/index.html.erb"
    response.should have_tag("tr>td", "MyText", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

