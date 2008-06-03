class Box < ActiveRecord::Base
  belongs_to :jivepage
  belongs_to :column
  acts_as_list :scope => :column
  before_save :set_defaults

  # set_inheritance_column "kind"  

  validates_presence_of :cell_kind
  delegate :row, :to => "(column or return nil)"
    
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
    logger.debug "begin move_to_column"
    new_column = new_column.kind_of?(Column) ? new_column : Column.find(new_column)
    return if new_column.id == self.column.id
    logger.debug "updating box column from #{column.id} to #{new_column.id}"
    self.update_attribute(:column, new_column)
    self.move_to_bottom
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
  
  
  protected
    def set_defaults
      self.jivepage_id ||= self.row.jivepage_id if self.row
    end
  
end
