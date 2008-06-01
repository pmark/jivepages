require File.dirname(__FILE__) + '/../spec_helper'

describe Contributorship do
  before(:each) do
    @contributorship = Contributorship.new
  end

  it "should be valid" do
    @contributorship.should be_valid
  end
end
