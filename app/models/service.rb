class Service < ActiveRecord::Base

  belongs_to :department
  has_many :businesses
  has_many :tasks

  symbolize :category, :in => [ :new_business, :fault_repair ], :scopes => true, :methods => true

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

