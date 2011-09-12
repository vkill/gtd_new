require 'spec_helper'

describe Service do
  it "should succeed creating a new :service from the Factory" do
    _1_service
  end
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

