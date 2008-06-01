require File.dirname(__FILE__) + '/../../spec_helper'

describe "/contributorships/edit.html.erb" do
  include ContributorshipsHelper
  
  before do
    @contributorship = mock_model(Contributorship)
    @contributorship.stub!(:user_id).and_return("1")
    @contributorship.stub!(:jivepage_id).and_return("1")
    assigns[:contributorship] = @contributorship
  end

  it "should render edit form" do
    render "/contributorships/edit.html.erb"
    
    response.should have_tag("form[action=#{contributorship_path(@contributorship)}][method=post]") do
    end
  end
end


