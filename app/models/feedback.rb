class Feedback < ActiveRecord::Base

  belongs_to :issue
  belongs_to :handler, :foreign_key => :handler_id, :class_name => "User"


  symbolize :category, :in => [ :good, :bad ], :scopes => true, :methods => true
  symbolize :state, :in => [ :pending, :processing, :processed ], :scopes => true, :methods => true


  include AASM
  aasm_column :state
  aasm_initial_state :pending
  aasm_state :pending
  aasm_state :processing, :enter => :build_handle_at
  aasm_state :processed, :enter => :build_handle_at
  aasm_event :processing do
    transitions :from => :pending, :to => :processing
  end
  aasm_event :processed do
    transitions :from => [:pending, :processing], :to => :processed
  end


  validates :issue, :existence => { :both => false }
  validates :body, :presence => true,
                    :length   => { :minimum => 10 }
  with_options :if => Proc.new { |record| record.processing? } do |processing|
    processing.validates :handler, :existence => { :both => false }
  end
  with_options :if => Proc.new { |record| record.processed? } do |processed|
    processed.validates :handler, :existence => { :both => false }
    processed.validates :result, :presence => true
  end


  with_options :if => Proc.new { |record| record.processing? } do |processing|
    processing.before_validation :build_handler
    processing.before_save :build_handle_at
  end
  with_options :if => Proc.new { |record| record.processed? } do |processed|
    processed.before_validation :build_handler
    processed.before_save :build_handle_at
  end


  private
    def build_handler
      self.handler = User.current
    end

    def build_handle_at
      self.handle_at = Time.zone.now
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

