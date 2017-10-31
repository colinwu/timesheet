class Expense < ActiveRecord::Base
  attr_accessible :date, :amount, :desc, :money, :project_id, :hst
  belongs_to :project
end
