class Issue < ActiveRecord::Base

  belongs_to :user
  belongs_to :assigner, :foreign_key => :assigner_id, :class_name => "User"
  belongs_to :accepter, :foreign_key => :accepter_id, :class_name => "User"
  belongs_to :service
  has_one :evaluation, :as => :evaluationable
  has_one :feedback

  symbolize :state, :in => [ :pending, :assigned, :accepted, :finished, :expired], :scopes => true, :methods => true
end

