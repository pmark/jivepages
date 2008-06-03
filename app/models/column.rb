class Column < ActiveRecord::Base
  belongs_to :jivepage
  belongs_to :row
  acts_as_list :scope => :row
  has_many :boxes, :dependent => :destroy
  
  def dom_id
    "column-#{self.id}"
  end

  def move_boxes_to(target_column)
    logger.debug "moving boxes in column #{self.id} to column #{target_column.id}"
    count = 0
    self.boxes.each do |box| 
      logger.debug "moving box #{box.id} to column #{target_column.id}"
      box.move_to_column(target_column)
      count += 1
    end
    self.boxes.reload        
    count
  end
  
  def anchor_to_sibling(sibling, position)
    self.jivepage = sibling.jivepage
    self.grid_type = sibling.grid_type if sibling.sidebar? or 
        sibling.header? or sibling.footer?
    
    return false unless self.save    
    if position == :before
      # TODO: use list functions instead
      self.move_to_left_of(sibling)
    else
      self.move_to_right_of(sibling)
    end
    true
  end
  
  def create_box!(cell_kind=nil, position=nil, options={})
    options[:cell_kind] ||= "textblock"
    options[:cell_kind] = options[:cell_kind].classify
    self.boxes.create!(options)
  end
  
  def inspect_boxes
    "<#{self.dom_id}: [" +
    children.collect do |column|
      "<#{column.dom_id}: [#{column.boxes.collect(&:dom_id).join(', ')}]>"
    end.join(', ') + "]>"
  end
  
end


