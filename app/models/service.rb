class Service < ActiveRecord::Base

  belongs_to :department
  has_many :businesses, :foreign_key => :service_id, :class_name => "Business"
  has_many :tasks, :foreign_key => :service_id, :class_name => "Task"


  symbolize :category, :in => [ :new_business, :fault_repair, :other ], :scopes => true, :methods => true


  default_scope order('created_at DESC')


  delegate :name, :to => :department, :prefix => true, :allow_nil => true


  validates :name, :presence => true,
                    :uniqueness => true,
                    :length => { :maximum => 20 }
  validates :expired_date_hours, :presence => true
  validates :department, :existence => { :both => false }

end


# == Schema Information
#
# Table name: services
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  describtion        :text
#  category           :string(255)     default("new_business")
#  expired_date_hours :integer
#  department_id      :integer
#  created_at         :datetime
#  updated_at         :datetime
#

