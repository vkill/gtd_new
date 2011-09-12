require 'spec_helper'

describe Department do
  it "should succeed creating a new :department from the Factory" do
    _1_department
  end
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

