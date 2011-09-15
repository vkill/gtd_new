class Department < ActiveRecord::Base

  has_ancestry


  has_many :users
  has_many :services
  has_many :businesses, :foreign_key => :service_id, :class_name => "Business", :through => :services
  has_many :tasks, :foreign_key => :service_id, :class_name => "Task", :through => :services


  default_scope order('created_at DESC')


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

