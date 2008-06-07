class Row < ActiveRecord::Base
  belongs_to :jivepage
  acts_as_list :scope => 'jivepage_id = #{jivepage_id} AND section = \'#{section}\''
  has_many :columns, :dependent => :destroy, :order => "position ASC"

  before_validation :set_defaults
  after_save :adjust_columns

  validates_presence_of :jivepage, :grid_type, :section
  
  
  # grid types
  FULL = "100"
  HALVES = "5050"
  THIRDS = "333333"
  FOURTHS = "25252525"
  LEFT = "6633"
  RIGHT = "3366"
  UNIT = "unit"
  
  # page sections
  HEADER = "header"
  FOOTER = "footer"
  SIDEBAR = "sidebar"
  BODY = "body"
  
  # movements
  DOWN = 1
  UP = 2

  # css class names
  YUI_GRID_TYPES = {
    FULL => "yui-g",
    HALVES => "yui-g",
    THIRDS => "yui-gb",
    FOURTHS => "yui-g",
    LEFT => "yui-gc",
    RIGHT => "yui-gd",
    UNIT => "yui-u"
  }

  def dom_id
    "row-#{self.id}"
  end
  
  def yui_grid_type    
    type = self.grid_type
    type ||= FULL    
    YUI_GRID_TYPES[type]
  end
  
  def change_grid_type(new_type, force=false)
    return unless force or new_type != self.grid_type
    update_attribute(:grid_type, new_type)  
    adjust_columns
  end
  
  def sidebar?
    self.grid_type == SIDEBAR
  end
  
  def header?
    self.grid_type == HEADER
  end
  
  def footer?
    self.grid_type == FOOTER
  end
  
  def adjust_columns
    mod_count = compute_child_mod_count
    if mod_count < 0
      merge_columns(mod_count.abs)
    elsif mod_count > 0
      insert_columns(mod_count)
    end      
  end
  
  def move(dir)
    move_message = (dir == DOWN ? :move_lower : :move_higher)
    self.send(move_message)
  end
  
  
  #
  #
  #
  protected
    def set_defaults
      self.grid_type ||= FULL
      self.section ||= BODY
    end
    
    # Compare current grid_type to actual number of columns and return difference.
    # A negative number means there are too many columns.
    def compute_child_mod_count
      target_child_count = case self.grid_type
      when FULL
        1
      when HALVES, LEFT, RIGHT
        2
      when THIRDS
        3
      else
        0
      end
      (target_child_count - self.columns.size)
    end

    # Create a number of columns.
    def insert_columns(add_count)
      add_count.times do
        new_column = self.columns.create(:jivepage => jivepage)
        new_column.create_box!("textblock", 1, 
            :content => "Click here to change text.") if new_column.first?
      end
    end

    # Collapse a number of columns into their previous siblings.
    def merge_columns(prune_count)
      prune_count = columns.size if prune_count > columns.size
      return unless prune_count > 0
      prune_count.times do
        break unless columns.size > 1
        dying_column = columns.pop
        previous_sibling = columns.last
        dying_column.move_boxes_to(previous_sibling)
        dying_column.destroy
      end
    end    
end


