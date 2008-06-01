require File.dirname(__FILE__) + '/../../spec_helper'

describe "/boxes/show.html.erb" do
  include BoxesHelper
  
  before(:each) do
    @box = mock_model(Box)
    @box.stub!(:jivepage_id).and_return("1")
    @box.stub!(:cell_id).and_return("1")
    @box.stub!(:content).and_return("MyText")
    @box.stub!(:position).and_return("1")

    assigns[:box] = @box
  end

  it "should render attributes in <p>" do
    render "/boxes/show.html.erb"
    response.should have_text(/MyText/)
    response.should have_text(/1/)
  end
end

