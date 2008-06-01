require File.dirname(__FILE__) + '/../../spec_helper'

describe "/contributorships/show.html.erb" do
  include ContributorshipsHelper
  
  before(:each) do
    @contributorship = mock_model(Contributorship)
    @contributorship.stub!(:user_id).and_return("1")
    @contributorship.stub!(:jivepage_id).and_return("1")

    assigns[:contributorship] = @contributorship
  end

  it "should render attributes in <p>" do
    render "/contributorships/show.html.erb"
  end
end

