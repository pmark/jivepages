require File.dirname(__FILE__) + '/../../spec_helper'

describe "/edit_sessions/index.html.erb" do
  include EditSessionsHelper
  
  before(:each) do
    edit_session_98 = mock_model(EditSession)
    edit_session_98.should_receive(:user_id).and_return("1")
    edit_session_98.should_receive(:jivepage_id).and_return("1")
    edit_session_99 = mock_model(EditSession)
    edit_session_99.should_receive(:user_id).and_return("1")
    edit_session_99.should_receive(:jivepage_id).and_return("1")

    assigns[:edit_sessions] = [edit_session_98, edit_session_99]
  end

  it "should render list of edit_sessions" do
    render "/edit_sessions/index.html.erb"
  end
end

