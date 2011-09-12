class Issue < ActiveRecord::Base

  has_event_calendar
  include AASM


  belongs_to :user
  belongs_to :assigner, :foreign_key => :assigner_id, :class_name => "User"
  belongs_to :accepter, :foreign_key => :accepter_id, :class_name => "User"
  belongs_to :service
  has_one :evaluation, :as => :evaluationable
  has_one :feedback

  delegate :email, :name, :to => :user, :prefix => true
  delegate :name, :expired_date_hours, :to => :service, :prefix => true


  symbolize :state, :in => [ :pending, :assigned, :accepted, :finished, :expired], :scopes => true, :methods => true


  aasm_column :state
  aasm_initial_state :pending
  aasm_state :pending
  aasm_state :assigned
  aasm_state :accepted
  aasm_state :finished
  aasm_state :expired
  aasm_event :assigned do
    transitions :from => :pending, :to => :assigned
  end
  aasm_event :accepted do
    transitions :from => :assigned, :to => :accepted
  end
  aasm_event :finished do
    transitions :from => :accepted, :to => :finished
  end
  aasm_event :expired do
    transitions :from => [:pending, :assigned, :accepted], :to => :expired
  end


  validates :body, :presence => true,
                    :length   => { :minimum => 10 }
  validates_datetime :accept_at, :before => :expired_date, :if => Proc.new{|record| record.accepted?}
  validates_datetime :finish_at, :before => :expired_date, :if => Proc.new{|record| record.finished?}


  before_save :build_expired_date, :on => :create
  before_validation :build_been_at

  private

  def build_expired_date
    self.expired_date = Time.now + self.service_expired_date_hours.hours
  end

  def build_been_at
    (self.assign_at ||= Time.now) if self.assigned?
    (self.accept_at ||= Time.now) if self.accepted?
    (self.finish_at ||= Time.now) if self.finished?
  end


end


# == Schema Information
#
# Table name: issues
#
#  id            :integer         not null, primary key
#  body          :text
#  state         :string(255)     default("pending")
#  assigner_id   :integer
#  accepter_id   :integer
#  assign_remark :text
#  assign_at     :datetime
#  solution      :text
#  accept_at     :datetime
#  result        :text
#  finish_at     :datetime
#  user_id       :integer
#  service_id    :integer
#  type          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  expired_date  :datetime
#  name          :string(255)
#  start_at      :datetime
#  end_at        :datetime
#

