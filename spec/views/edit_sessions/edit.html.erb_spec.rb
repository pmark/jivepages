require File.dirname(__FILE__) + '/../../spec_helper'

describe "/edit_sessions/edit.html.erb" do
  include EditSessionsHelper
  
  before do
    @edit_session = mock_model(EditSession)
    @edit_session.stub!(:user_id).and_return("1")
    @edit_session.stub!(:jivepage_id).and_return("1")
    assigns[:edit_session] = @edit_session
  end

  it "should render edit form" do
    render "/edit_sessions/edit.html.erb"
    
    response.should have_tag("form[action=#{edit_session_path(@edit_session)}][method=post]") do
    end
  end
end


