class CreateEditSessions < ActiveRecord::Migration
  def self.up
    create_table :edit_sessions do |t|
      t.integer :user_id
      t.integer :jivepage_id

      t.timestamps
    end
  end

  def self.down
    drop_table :edit_sessions
  end
end
