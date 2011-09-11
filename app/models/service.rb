class Service < ActiveRecord::Base

  belongs_to :department
  has_many :businesses
  has_many :tasks

  symbolize :category, :in => [ :new_business, :fault_repair ], :scopes => true, :methods => true

end

