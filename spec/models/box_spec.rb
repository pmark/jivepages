require File.dirname(__FILE__) + '/../spec_helper'

describe Box do
  before(:each) do
    @box = Box.create!(:cell_kind => "textblock")
  end
  
  it "should be valid" do    
    @box.should be_valid
  end  

end