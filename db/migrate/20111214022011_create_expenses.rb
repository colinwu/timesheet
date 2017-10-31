class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.date :date
      t.float :amount
      t.string :desc
      t.boolean :money
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
