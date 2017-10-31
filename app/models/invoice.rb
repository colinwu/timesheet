class Invoice < ActiveRecord::Base
  attr_accessible :project_id, :invoice_date, :paid_date, :memo
  belongs_to :project
  has_many :events

  validates_presence_of :invoice_date
end
