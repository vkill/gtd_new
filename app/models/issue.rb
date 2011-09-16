class Issue < ActiveRecord::Base

  has_event_calendar :start_at_field  => 'start_at', :end_at_field => 'expired_date'


  belongs_to :user
  belongs_to :editor, :foreign_key => :user_id, :class_name => "User"
  belongs_to :assigner, :foreign_key => :assigner_id, :class_name => "User"
  belongs_to :accepter, :foreign_key => :accepter_id, :class_name => "User"
  belongs_to :service
  has_one :evaluation, :as => :evaluationable
  has_one :feedback
  accepts_nested_attributes_for :feedback
  accepts_nested_attributes_for :evaluation


  symbolize :state, :in => [ :pending, :assigned, :accepted, :finished, :expired], :scopes => true, :methods => true


  default_scope order('created_at DESC')


  delegate :email, :name, :to => :editor, :prefix => true, :allow_nil => true
  delegate :email, :name, :to => :assigner, :prefix => true, :allow_nil => true
  delegate :email, :name, :to => :accepter, :prefix => true, :allow_nil => true
  delegate :name, :to => "editor.try(:department)", :prefix => :editor_department, :allow_nil => true
  delegate :name, :to => :service, :prefix => true
  delegate :expired_date_hours, :to => :service
  delegate :name, :to => "service.try(:department)", :prefix => :service_department, :allow_nil => true


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


  validates :service, :existence => { :both => false }
  validates :body, :presence => true,
                    :length   => { :minimum => 10 }
  with_options :if => Proc.new { |record| record.assigned? } do |assigned|
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
    expired.validates_datetime :expired_date, :before => lambda { Time.now }
  end


  before_create :build_editor, :build_expired_date, :build_start_at
  before_save :build_name
  with_options :if => Proc.new { |record| record.assigned? } do |assigned|
    assigned.before_create :build_assign_at
    assigned.before_save :build_assigner
  end
  with_options :if => Proc.new { |record| record.expired? } do |expired|
    expired.before_create :build_state_before_expired
  end

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

    def build_editor
      self.editor = User.current
    end

    def build_expired_date
      self.expired_date = Time.zone.now + self.expired_date_hours.hours
    end

    def build_name
      self.name = self.body.to_s[0,20] if self.name.blank?
    end

    def build_assigner
      self.assigner = User.current
    end

    def build_start_at
      self.start_at = Time.zone.now
    end
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

