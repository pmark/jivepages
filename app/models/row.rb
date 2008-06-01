class Row < ActiveRecord::Base
  belongs_to :jivepage
  acts_as_list :scope => 'jivepage_id = #{jivepage_id} AND section = #{section}'
  has_many :columns, :dependent => :destroy
  before_save :set_defaults
  after_save :create_first_column
  
  
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
  
  def change_grid_type(new_type)
    self.update_attribute(:grid_type, new_type)  
    mod_count = compute_child_mod_count
    if mod_count < 0
      merge_children(mod_count.abs)
    elsif mod_count > 0
      insert_units(mod_count)
    end      
    self.reload
  end
  
  def compute_child_mod_count
    target_child_count = case self.grid_type
    when FULL
      0
    when HALVES, LEFT, RIGHT
      2
    when THIRDS
      3
    else
      0
    end
    (target_child_count - self.children.size)
  end
  
  # Create child columns 
  def insert_units(add_count)
    # move root boxes down into left column if there's 1 child
    
    add_count.times do
      self.jivepage.columns.create(
        :grid_type => UNIT).move_to_child_of(self)
    end
  end
  
  def merge_children(prune_count)
    puts "\nMERGE(#{prune_count}): #{inspect_boxes}\n\n"
    prune_count = children.size if prune_count > children.size
    return unless prune_count > 0
    prune_count.times do
      if self.children.size == 2
        # no grid types should ever use only 2 columns
        merge_children_to_self
        break
      end

      dying_column = self.children.last
      target_column = dying_column.siblings.last
      dying_column.move_boxes_to(target_column)
      puts "\nDeleting #{dying_column.dom_id}..."
      dying_column.destroy
    end

    puts "\n--DONE(#{prune_count}): children: #{inspect_boxes}\n\n"
  end

  def move_boxes_to(target_column)
    target_column.boxes.each do |box| 
      puts "Moving #{box.dom_id} to parent #{target_column.dom_id}"
      box.move_to_column(target_column)
    end
  end
  
  # TODO: this makes no sense anymore
  def merge_children_to_self
    self.children.each do |column|
      column.move_boxes_to(self)
      column.destroy
    end
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
  
  
  protected
    def set_defaults
      self.grid_type ||= FULL
    end
    
    def create_first_column
      return unless columns.blank?
      self.columns.create
    end
end


