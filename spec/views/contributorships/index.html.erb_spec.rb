require File.dirname(__FILE__) + '/../../spec_helper'

describe "/contributorships/index.html.erb" do
  include ContributorshipsHelper
  
  before(:each) do
    contributorship_98 = mock_model(Contributorship)
    contributorship_98.should_receive(:user_id).and_return("1")
    contributorship_98.should_receive(:jivepage_id).and_return("1")
    contributorship_99 = mock_model(Contributorship)
    contributorship_99.should_receive(:user_id).and_return("1")
    contributorship_99.should_receive(:jivepage_id).and_return("1")

    assigns[:contributorships] = [contributorship_98, contributorship_99]
  end

  it "should render list of contributorships" do
    render "/contributorships/index.html.erb"
  end
end

