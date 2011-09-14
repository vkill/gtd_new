class Department < ActiveRecord::Base

  has_ancestry


  has_many :users
  has_many :services


  validates :name, :presence => true,
                    :uniqueness => true,
                    :length   => { :maximum => 15 }

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

