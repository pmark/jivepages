require File.dirname(__FILE__) + '/../spec_helper'

describe EditSession do
  before(:each) do
    @edit_session = EditSession.new
  end

  it "should be valid" do
    @edit_session.should be_valid
  end
end
