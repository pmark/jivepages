require File.dirname(__FILE__) + '/../spec_helper'

describe Box, "undergoing a grid_type change" do
  before(:each) do
    @jivepage = Jivepage.create
    @root_box = @jivepage.boxes.create
    # @root_box.change_grid_type(Box::THIRDS)
    # @left, @middle, @right = @root_box.children
    # @cell1 = @middle.cells.create({:kind => "Textblock"})
    # @cell2 = @right.cells.create({:kind => "Textblock"})
  end
  
  it "should have the proper number of boxes, first of all" do    
    @jivepage.boxes.size.should == 1
    @root_box.children.size.should == 0
  end  

  it "from FULL to HALVES should insert 2 units" do    
    @root_box.grid_type = Box::FULL
    @root_box.should_receive(:compute_child_mod_count).once.and_return(2)
    @root_box.should_receive(:insert_units).once.with(2)
    @root_box.change_grid_type(Box::HALVES)      
  end
  
  it "from FULL to THIRDS should insert 3 units" do    
    @root_box.grid_type = Box::FULL
    @root_box.should_receive(:insert_units).once.with(3)
    @root_box.change_grid_type(Box::THIRDS)      
  end
  
  it "from HALVES to THIRDS should insert 1 unit" do
    @root_box.grid_type = Box::HALVES
    @root_box.should_receive(:compute_child_mod_count).once.and_return(1)
    @root_box.should_receive(:insert_units).once.with(1)
    @root_box.change_grid_type(Box::THIRDS)      
  end
  
  it "should move all child cells up to the root box when grid type changes to FULL"  
  it "should not change any cell positions when adding third box"  
end

describe Box, "with FULL grid type and a cell" do
  before(:each) do
    @jivepage = Jivepage.create
    @root_box = @jivepage.boxes.create
    @cell = @root_box.create_cell
  end
  
  it "should have the proper number of boxes, first of all" do    
    @jivepage.boxes.size.should == 1
    @root_box.children.size.should == 0
    @cell.box.should == @root_box
  end  

  it "should move root cell to new leftmost box when grid type changes to HALVES" do
    lambda {
      @root_box.change_grid_type(Box::HALVES)      
    }.should_not change(Cell, :count)    
  end
end

describe Box, "with THIRDS grid type and some cells" do
  before(:each) do
    @jivepage = Jivepage.create
    @root_box = @jivepage.boxes.create(:grid_type => Box::THIRDS)
    @root_box.insert_units(3)
    @left_box = @root_box.children[0]
    @middle_box = @root_box.children[1]
    @right_box = @root_box.children[2]    
    @root_cell, @left_cell, @middle_cell, @right_cell = @cells = [@root_box.create_cell] +
        @root_box.children.collect(&:create_cell)
  end
  
  it "should have the proper number of boxes, first of all" do    
    @jivepage.boxes.size.should == 4
    @root_box.children.size.should == 3
    @cells.size.should == 4
  end  

  it "should merge cells from right box into middle box" do
    lambda {
      @root_box.merge_children(1)
    }.should_not change(Cell, :count)
    @right_cell.reload.box_id.should == @middle_box.id
  end  
  
  it "should merge all child cells into root box" do    
    puts("\nstart cells: ---- #{@cells.collect(&:id).join(', ')}")
    lambda {
      @root_box.merge_children(3)
    }.should_not change(Cell, :count)
    @left_cell.reload.box_id.should == @root_box.id
    @middle_cell.reload.box_id.should == @root_box.id
    @right_cell.reload.box_id.should == @root_box.id
  end
end
