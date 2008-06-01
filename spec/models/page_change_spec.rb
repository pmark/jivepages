require File.dirname(__FILE__) + '/../spec_helper'

describe PageChange do
  before(:each) do
    @page_change = PageChange.new
  end

  it "should be valid" do
    @page_change.should be_valid
  end
end
