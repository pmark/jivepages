require File.dirname(__FILE__) + '/../../spec_helper'

describe "/edit_sessions/new.html.erb" do
  include EditSessionsHelper
  
  before(:each) do
    @edit_session = mock_model(EditSession)
    @edit_session.stub!(:new_record?).and_return(true)
    @edit_session.stub!(:user_id).and_return("1")
    @edit_session.stub!(:jivepage_id).and_return("1")
    assigns[:edit_session] = @edit_session
  end

  it "should render new form" do
    render "/edit_sessions/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", edit_sessions_path) do
    end
  end
end


