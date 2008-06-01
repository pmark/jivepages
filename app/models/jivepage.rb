class Jivepage < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper

  # belongs_to :user
  has_many :contributorships, :dependent => :delete_all
  has_many :contributors, :through => :contributorships, :source => :user
  has_many :rows do 
    def in_body 
      find_all_by_section(Row::BODY) 
    end
    def in_header 
      find_all_by_section(Row::HEADER) 
    end
    def in_footer 
      find_all_by_section(Row::FOOTER) 
    end
    def in_sidebar 
      find_all_by_section(Row::SIDEBAR) 
    end
  end
  has_many :edit_sessions, :dependent => :destroy
  # has_many :editors, :through => :edit_sessions, :source => :user
  
  before_save :restructure
  
  NO_SIDEBAR = "none"
  RIGHT_SIDEBAR = "right"
  LEFT_SIDEBAR = "left"
  COMPACT_LAYOUT = "compact"
  WIDE_LAYOUT = "wide"
  FLUID_LAYOUT = "fluid"
  
  def self.create_and_setup(options={})
    jivepage = Jivepage.create!(options)
    jivepage.setup
    jivepage
  end
  
  def setup
    row = self.rows.create!(:section => "body")
    row.columns.first.create_box("textblock", 1, :content => "Click this text to change it.")
  end
  
  def self.uses_users?
    defined?(User)
  end
  
  def editable_by?(user)
    return true unless Jivepage.uses_users?
    user && (user.id == user_id || user.contributor_to?(self))
  end
  
  def being_edited_by?(user)
    return true unless Jivepage.uses_users?
    being_edited? and edit_sessions.exists?(:user_id => user.id)
  end
  
  def being_edited?
    return true unless Jivepage.uses_users?
    !edit_sessions.blank?
  end

  # Right now pmark is writing about Lavender Oil 
  # and there are 2 other contributors, 
  # ...although only pmark is editing it currently.
  # ...There are 3 people currently editing this page.
  def heading
    return "" unless Jivepage.uses_users?
    
    owner = self.user || User.find_anonymous
    who = owner.summary    
    about = subject ? " about #{subject.summary}" : nil
    if being_edited_by?(owner)
      when_last_edited = "Right now" 
      action = about ? "is writing" : "is editing this page"
      editor_summary = editors.size < 2 ? 
          "Nobody else is editing at the moment" :
          "There #{is_are(editors.size)} #{pluralize(editors.size, 'editor')} at the moment"
    else
      last_edit_timestamp = updated_at || created_at
      when_last_edited = last_edit_timestamp ? 
          "#{time_ago_in_words(last_edit_timestamp).capitalize} ago": ''
      action = "wrote"
      editor_summary = (contributors.blank? && editors.blank?) ? 
          "Nobody is editing this page at the moment" :
          "There are #{pluralize(editors.size, 'editor')} editing right now"
          
    end

    contributor_summary = contributors.blank? ? '' : 
        " with #{pluralize(contributors.size, 'contributor')}"
    
    return %(#{when_last_edited} #{who} #{action}#{about}#{contributor_summary}.  #{editor_summary}.).squeeze(' ')
  end
  
  def summary 
    title
  end    
  
  def dom_id
    "jivepage-#{id}"
  end
  
  def is_are(count)
    (count == 1) ? "is" : "are"
  end
  
  def sidebar?
    self.sidebar and self.sidebar != NO_SIDEBAR
  end
  
  protected
    #
    #
    #
    def restructure
      self.width ||= COMPACT_LAYOUT
      self.sidebar ||= NO_SIDEBAR
      reset_layout
      reset_skin
    end
    
    #
    #
    #
    def reset_layout
      self.layout = case self.width
      when COMPACT_LAYOUT
        "doc"
      when WIDE_LAYOUT
        "doc4"
      when FLUID_LAYOUT
        "doc3"
      end
    end
  
    #
    #
    #
    def reset_skin
      self.skin = case self.sidebar
      when NO_SIDEBAR
        nil
      when LEFT_SIDEBAR
        (width == COMPACT_LAYOUT) ? "yui-t2" : "yui-t3"
      when RIGHT_SIDEBAR
        (width == COMPACT_LAYOUT) ? "yui-t4" : "yui-t6"
      end
    end
  
end
