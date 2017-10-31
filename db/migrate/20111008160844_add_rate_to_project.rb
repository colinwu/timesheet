class AddRateToProject < ActiveRecord::Migration
  def change
    add_column :projects, :rate, :float
  end
end
