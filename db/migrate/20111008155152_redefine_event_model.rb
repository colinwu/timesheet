class RedefineEventModel < ActiveRecord::Migration
  def up
    remove_column :events, :event_type
    rename_column :events, :timestamp, :end_at
    add_column :events, :invoice_id, :integer
  end

  def down
    add_column :events, :event_type, :string
    rename_column :events, :end_at, :timestamp
    remove_column :events, :invoice_id
  end
end
