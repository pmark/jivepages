class CreateContributorships < ActiveRecord::Migration
  def self.up
    create_table :contributorships do |t|
      t.integer :user_id
      t.integer :jivepage_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contributorships
  end
end
