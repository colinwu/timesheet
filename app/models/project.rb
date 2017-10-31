class Project < ActiveRecord::Base
  attr_accessible :name, :description, :contact_id, :rate
  has_many :events
  belongs_to :contact

  validates_presence_of :contact_id
  validates_presence_of :rate
end
