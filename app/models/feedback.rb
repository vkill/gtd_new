class Feedback < ActiveRecord::Base

  belongs_to :issue
  belongs_to :handler, :foreign_key => :handler_id, :class_name => "User"

  symbolize :category, :in => [ :good, :bad ], :scopes => true, :methods => true
  symbolize :state, :in => [ :pending, :processing, :processed ], :scopes => true, :methods => true

end

