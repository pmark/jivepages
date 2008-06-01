class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.integer :jivepage_id
      t.integer :column_id
      t.text :content
      t.integer :position
      t.string :kind, :limit => 25
      t.string :target, :limit => 255
      t.string :state, :limit => 50

      t.timestamps
    end
  end

  def self.down
    drop_table :boxes
  end
end
