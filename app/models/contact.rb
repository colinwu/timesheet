class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :address
end
