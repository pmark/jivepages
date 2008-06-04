require File.dirname(__FILE__) + '/../spec_helper'

describe Row, "being created" do
  before(:each) do
    @jivepage = Jivepage.create
    @row = Row.create!(:jivepage => @jivepage)
  end

  it "should have be valid" do
    @row.should be_valid
  end

  it "should have a FULL grid type by default" do
    @row.grid_type.should == Row::FULL
  end
  
  it "should be a BODY section by default" do
    @row.section.should == Row::BODY
  end  
end

describe Row, "being saved" do
  before(:each) do
    @row = Row.create!(:jivepage => Jivepage.create)
  end

  it "should run before filters" do
    @row.should_receive(:set_defaults)
    @row.save!
  end
  
  it "should have 1 column and 1 textblock" do
    @row.columns.size.should == 1
  end

  it "should have 1 textblock in its column" do
    @row.columns.first.boxes.size.should == 1
  end

  it "should automatically adjust the columns after saving" do
    @row.columns.size.should == 1
    @row.grid_type = Row::HALVES
    @row.should_receive(:adjust_columns)
    @row.save!       
  end  
end

describe Row, "with FULL format undergoing a grid_type change" do
  before(:each) do
    @jivepage = Jivepage.create!
    @row = Row.create!(:jivepage => @jivepage, :grid_type => Row::FULL)
  end
  
  it "should have the proper number of columns, first of all" do    
    @row.columns.size.should == 1
  end  

  it "to HALVES should insert 1 columns" do    
    @row.should_receive(:compute_child_mod_count).once.and_return(1)
    @row.should_receive(:insert_columns).once.with(1)
    @row.grid_type = Row::HALVES
    @row.save
  end
  
  it "to THIRDS should insert 2 columns" do    
    @row.should_receive(:compute_child_mod_count).once.and_return(2)
    @row.should_receive(:insert_columns).once.with(2)
    @row.grid_type = Row::THIRDS
    @row.save
  end  
end

describe Row, "with HALVES format undergoing a grid_type change" do
  before(:each) do
    @jivepage = Jivepage.create!
    @row = Row.create!(:jivepage => @jivepage, :grid_type => Row::HALVES)
  end
  
  it "to THIRDS should insert 1 column" do
    @row.should_receive(:compute_child_mod_count).once.and_return(1)
    @row.should_receive(:insert_columns).once.with(1)
    @row.grid_type = Row::THIRDS
    @row.save
  end

  it "to FULL should delete 1 column" do
    @row.should_receive(:compute_child_mod_count).once.and_return(-1)
    @row.should_receive(:merge_columns).once.with(1)
    @row.grid_type = Row::THIRDS
    @row.save
  end
end


describe Row, "with THIRDS format undergoing a grid_type change" do
  before(:each) do
    @jivepage = Jivepage.create!
    @row = Row.create!(:jivepage => @jivepage, :grid_type => Row::THIRDS)    
  end
  
  it "should have the proper number of boxes, first of all" do    
    @jivepage.rows.size.should == 1
    @row.columns.size.should == 3
  end  

  it "to FULL should delete 2 columns" do
    @row.grid_type = Row::FULL
    @row.should_receive(:compute_child_mod_count).once.and_return(-2)
    @row.should_receive(:merge_columns).once.with(2)
    @row.save
  end    

  it "to HALVES should delete 1 columns" do
    @row.grid_type = Row::HALVES
    @row.should_receive(:compute_child_mod_count).once.and_return(-1)
    @row.should_receive(:merge_columns).once.with(1)
    @row.save
  end    

  it "to HALVES should delete 1 column" do
    lambda {
      @row.grid_type = Row::HALVES
      @row.save
    }.should change(Column, :count).by(-1)
  end    

  it "to FULL should delete 2 columns" do
    lambda {
      @row.grid_type = Row::FULL
      @row.save
    }.should change(Column, :count).by(-2)
  end    

  it "to HALVES should merge boxes and not delete them" do
    lambda {
      @row.grid_type = Row::HALVES
      @row.save
    }.should_not change(Box, :count)
  end    

  it "to FULL should merge boxes and not delete them" do
    lambda {
      @row.grid_type = Row::FULL
      @row.save
    }.should_not change(Box, :count)
  end    
end

describe Row, "being moved" do
  before(:each) do
    @jivepage = Jivepage.create
    @row1 = @jivepage.rows.create!()
    @row2 = @jivepage.rows.create!()
  end

  it "should have 2 rows" do
    @row1.position.should == 1
    @row2.position.should == 2
  end
  
  it "should call move_lower when moving down" do
    @row1.should_receive(:move_lower)
    @row1.move(Row::DOWN)
  end

  it "should call move_higher when moving up" do
    @row1.should_receive(:move_higher)
    @row1.move(Row::UP)
  end
end


