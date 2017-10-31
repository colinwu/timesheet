class AddHstToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :hst, :float
  end
end
