require File.dirname(__FILE__) + '/../../spec_helper'

describe "/edit_sessions/show.html.erb" do
  include EditSessionsHelper
  
  before(:each) do
    @edit_session = mock_model(EditSession)
    @edit_session.stub!(:user_id).and_return("1")
    @edit_session.stub!(:jivepage_id).and_return("1")

    assigns[:edit_session] = @edit_session
  end

  it "should render attributes in <p>" do
    render "/edit_sessions/show.html.erb"
  end
end

