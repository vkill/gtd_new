class Task < Issue
end


# == Schema Information
#
# Table name: issues
#
#  id                   :integer         not null, primary key
#  body                 :text
#  state                :string(255)     default("pending")
#  assigner_id          :integer
#  accepter_id          :integer
#  assign_remark        :text
#  assign_at            :datetime
#  solution             :text
#  accept_at            :datetime
#  result               :text
#  finish_at            :datetime
#  user_id              :integer
#  service_id           :integer
#  type                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  expired_date         :datetime
#  name                 :string(255)
#  start_at             :datetime
#  end_at               :datetime
#  state_before_expired :string(255)
#

