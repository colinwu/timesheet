class Event < ApplicationRecord
  
  belongs_to :project
  belongs_to :invoice, optional: true

  validates_presence_of :project_id
  validates_numericality_of :rate
  validates_presence_of :description, :on => 'update'
end