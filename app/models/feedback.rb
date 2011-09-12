class Feedback < ActiveRecord::Base

  belongs_to :issue
  belongs_to :handler, :foreign_key => :handler_id, :class_name => "User"

  symbolize :category, :in => [ :good, :bad ], :scopes => true, :methods => true
  symbolize :state, :in => [ :pending, :processing, :processed ], :scopes => true, :methods => true

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

