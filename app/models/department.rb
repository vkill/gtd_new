class Department < ActiveRecord::Base

  has_many :users
  has_many :services

  has_ancestry

end


# == Schema Information
#
# Table name: departments
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  describtion :text
#  created_at  :datetime
#  updated_at  :datetime
#  ancestry    :string(255)
#

