class CreatePageChanges < ActiveRecord::Migration
  def self.up
    create_table :page_changes do |t|
      t.integer :edit_session_id
      t.text :content
      t.text :script
      t.string :marker_element_id

      t.timestamps
    end
  end

  def self.down
    drop_table :page_changes
  end
end
