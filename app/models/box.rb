class Box < ActiveRecord::Base
  belongs_to :jivepage
  belongs_to :column
  acts_as_list :scope => :column

  # set_inheritance_column "kind"  

  validates_presence_of :cell_kind
    
  STATES = %w{index show edit admin icon}

  def cell_options
    {:box => self, :content => content}
  end
  
  def cell_name
    cell_kind.downcase.underscore
  end
  
  def dom_id
    "box-#{self.id}"
  end
  
  def reposition(new_position)
    update_attribute(:position, new_position)
  end
  
  def move_to_column(new_column)
    new_column = new_column.kind_of?(Column) ? new_column : Column.find(new_column)
    self.column = new_column
    self.move_to_bottom
    self.save
  end
  
  module CellIntegration
    def self.included(cell)
      cell.extend InstanceMethods
    end
    
    module InstanceMethods      
      def allow_forgery_protection
        ActionController::Base.allow_forgery_protection
      end

      def request_forgery_protection_token
        form_authenticity_token
      end    
    end
  end
  
end
