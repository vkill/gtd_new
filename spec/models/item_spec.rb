require 'spec_helper'

describe Item do
  it "should succeed creating a new :post from the Factory" do
    _1_post
  end

  it "should succeed creating a new :software from the Factory" do
    _1_software
  end
end


# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  permalink  :string(255)
#  content    :text
#  top        :boolean         default(FALSE)
#  category   :string(255)     default("none")
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

