class CreateRows < ActiveRecord::Migration
  def self.up
    create_table :rows do |t|
      t.integer :jivepage_id
      t.text :body
      t.string :section, :limit => 12
      t.integer :position
      t.string :grid_type, :limit => 12

      t.timestamps
    end
  end

  def self.down
    drop_table :rows
  end
end
