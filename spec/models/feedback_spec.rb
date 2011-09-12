require 'spec_helper'

describe Feedback do
  it "should succeed creating a new :feedback from the Factory" do
    _1_feedback
  end
end


# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer         not null, primary key
#  category   :string(255)     default("bad")
#  body       :text
#  state      :string(255)     default("pending")
#  result     :text
#  handler_id :integer
#  handle_at  :datetime
#  issue_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

