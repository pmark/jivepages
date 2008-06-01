class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.integer :row_id
      t.integer :position
      t.text :full_content
      # t.string :size, :limit => 12
      # t.string :orientation, :limit => 12

      t.timestamps
    end
  end

  def self.down
    drop_table :columns
  end
end
