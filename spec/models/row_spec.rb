require File.dirname(__FILE__) + '/../spec_helper'

describe Row do
  before(:each) do
    @row = Row.new
  end

  it "should be valid" do
    @row.should be_valid
  end
end
