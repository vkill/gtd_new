class Department < ActiveRecord::Base

  has_many :users
  has_many :services

  has_ancestry

end

