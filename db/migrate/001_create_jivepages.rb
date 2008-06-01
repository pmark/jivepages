class CreateJivepages < ActiveRecord::Migration
  def self.up
    create_table :jivepages do |t|
      t.integer :user_id
      t.string :title
      t.integer :subject_id
      t.string :subject_type
      t.string :width, :limit => 12
      t.string :sidebar, :limit => 12
      t.string :skin, :limit => 24
      t.string :layout, :limit => 24

      t.timestamps
    end
  end

  def self.down
    drop_table :jivepages
  end
end
