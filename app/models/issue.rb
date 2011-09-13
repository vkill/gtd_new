class Issue < ActiveRecord::Base

  has_event_calendar


  belongs_to :user
  belongs_to :editor, :foreign_key => :user_id, :class_name => "User"
  belongs_to :assigner, :foreign_key => :assigner_id, :class_name => "User"
  belongs_to :accepter, :foreign_key => :accepter_id, :class_name => "User"
  belongs_to :service
  has_one :evaluation, :as => :evaluationable
  has_one :feedback


  delegate :email, :name, :to => :editor, :prefix => true, :allow_nil => true
  delegate :email, :name, :to => :assigner, :prefix => true, :allow_nil => true
  delegate :email, :name, :to => :accepter, :prefix => true, :allow_nil => true
  delegate :name, :to => "editor.try(:department)", :prefix => :editor_department, :allow_nil => true
  delegate :name, :to => :service, :prefix => true
  delegate :expired_date_hours, :to => :service
  delegate :name, :to => "service.try(:department)", :prefix => :service_department, :allow_nil => true


  symbolize :state, :in => [ :pending, :assigned, :accepted, :finished, :expired], :scopes => true, :methods => true


  include AASM
  aasm_column :state
  aasm_initial_state Proc.new { |record| record.type == 'Business' ? :pending : :assigned }
  aasm_state :pending, :enter => :build_expired_date
  aasm_state :assigned, :enter => :build_assign_at
  aasm_state :accepted, :enter => :build_accept_at
  aasm_state :finished, :enter => :build_finish_at
  aasm_state :expired, :enter => :build_state_before_expired
  aasm_event :pending do
    transitions :from => :expired, :to => :pending
  end
  aasm_event :assigned do
    transitions :from => [:pending, :expired], :to => :assigned
  end
  aasm_event :accepted do
    transitions :from => [:assigned, :expired], :to => :accepted
  end
  aasm_event :finished do
    transitions :from => [:accepted, :expired], :to => :finished
  end
  aasm_event :expired do
    transitions :from => [:pending, :assigned, :accepted], :to => :expired
  end


  validates :user, :existence => { :both => false }
  validates :service, :existence => { :both => false }
  validates :body, :presence => true,
                    :length   => { :minimum => 10 }
  with_options :if => Proc.new { |record| record.assigned? } do |assigned|
    assigned.validates :assigner, :existence => { :both => false }
    assigned.validates :accepter, :existence => { :both => false }
  end
  with_options :if => Proc.new { |record| record.type == 'Business' and record.assigned? } do |business_assigned|
    business_assigned.validates_datetime :assign_at, :before => :expired_date
  end
  with_options :if => Proc.new { |record| record.accepted? } do |accepted|
    accepted.validates :solution, :presence => true
    accepted.validates_datetime :accept_at, :before => :expired_date
  end
  with_options :if => Proc.new { |record| record.finished? } do |finished|
    finished.validates :result, :presence => true
    finished.validates_datetime :finish_at, :before => :expired_date
  end
  with_options :if => Proc.new { |record| record.expired? } do |expired|
    expired.validates :state_before_expired, :presence => true
    expired.validates_datetime :expired_date, :before => lambda { Time.now }
  end


  after_create :build_expired_date
  after_create :build_assign_at, :if => Proc.new { |record| record.assigned? and record.type == 'Task' }

  private

    def build_assign_at
      self.assign_at = Time.zone.now
    end

    def build_accept_at
      self.accept_at = Time.zone.now
    end

    def build_finish_at
      self.finish_at = Time.zone.now
    end

    def build_state_before_expired
      self.state_before_expired = self.aasm_current_state
    end

    def build_expired_date
      self.expired_date = Time.zone.now + self.expired_date_hours.hours
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

