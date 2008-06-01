class EditSession < ActiveRecord::Base
  belongs_to :user
  belongs_to :jivepage
  has_many :page_changes
  validates_presence_of :user_id, :jivepage_id
  validate :uniqueness_of_relationship

  def self.for_page_and_user(jivepage, user)
    # params = {:jivepage_id => jivepage.id, :user_id => user.id}
    # self.find(:first, :conditions => params) ||
    #     self.create!(params)
  end


  protected
    def uniqueness_of_relationship
      if self.class.exists?(:user_id => user_id, :jivepage_id => jivepage_id)
        errors.add_to_base("Editing session already exists for this user/page.")
      end
    end
  
end
