require File.dirname(__FILE__) + '/../spec_helper'

describe Cell do
  before(:each) do
    @cell = Cell.new
  end

  it "should be valid" do
    @cell.should be_valid
  end
end
