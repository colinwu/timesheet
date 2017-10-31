class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :timestamp
      t.string :type
      t.integer :project_id
      t.string :description
      t.float :rate
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
