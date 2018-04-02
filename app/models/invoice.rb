class Invoice < ApplicationRecord
  belongs_to :project
  has_many :events

  validates_presence_of :invoice_date
end
