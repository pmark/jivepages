class Contributorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :jivepage
  validates_presence_of :user_id, :jivepage_id
  validate :uniqueness_of_relationship

  protected
  def uniqueness_of_relationship
    if self.class.exists?(:user_id => user_id, :jivepage_id => jivepage_id)
      errors.add_to_base("Contributor already exists for this page.")
    end
  end

end
