require File.dirname(__FILE__) + '/../../spec_helper'

describe "/contributorships/new.html.erb" do
  include ContributorshipsHelper
  
  before(:each) do
    @contributorship = mock_model(Contributorship)
    @contributorship.stub!(:new_record?).and_return(true)
    @contributorship.stub!(:user_id).and_return("1")
    @contributorship.stub!(:jivepage_id).and_return("1")
    assigns[:contributorship] = @contributorship
  end

  it "should render new form" do
    render "/contributorships/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", contributorships_path) do
    end
  end
end


