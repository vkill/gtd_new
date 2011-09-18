class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username, :name, :gender, :phone_number, :location, :about, :avatar, :department, :state
  attr_accessible :roles_mask

  has_attached_file :avatar,
                    :url => "/system/avatars/:id/:id-:style.:extension",
                    :path => ":rails_root/public/:url",
                    :styles => { :normal => '250x250>', :thumb => '50x50' },
                    :default_url => "/images/profile-avatar-thumb.jpg"
  validates_attachment_size :avatar, :less_than => 2.megabytes
  def url(*args)
    avatar.url(*args)
  end
  alias :public_filename :url
  def url_normal
    url(:normal)
  end
  def url_thumb
    url(:thumb)
  end

  #easy_roles
  easy_roles :roles_mask, :method => :bitmask
  ROLES_MASK = %w(admin chief staff boss)
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES_MASK.index(role.to_s)} > 0 "} }


  belongs_to :department
  has_many :posts, :foreign_key => :user_id, :class_name => "Post"
  has_many :softwares, :foreign_key => :user_id, :class_name => "Software"
  has_many :issues, :foreign_key => :user_id, :class_name => "Issue"
  has_many :assign_issues, :foreign_key => :assigner_id, :class_name => "Issue"
  has_many :accept_issues, :foreign_key => :accepter_id, :class_name => "Issue"
  has_many :businesses, :foreign_key => :user_id, :class_name => "Business"
  has_many :assign_businesses, :foreign_key => :assigner_id, :class_name => "Business"
  has_many :accept_businesses, :foreign_key => :accepter_id, :class_name => "Business"
  has_many :tasks, :foreign_key => :user_id, :class_name => "Task"
  has_many :assign_tasks, :foreign_key => :assigner_id, :class_name => "Task"
  has_many :accept_tasks, :foreign_key => :accepter_id, :class_name => "Task"
  has_many :handle_feedbacks, :foreign_key => :handler_id, :class_name => "Feedback"


  symbolize :gender, :in => [ :male, :female ], :scopes => true, :methods => true
  symbolize :state, :in => [ :pending, :actived, :paused, :deleted ], :scopes => true, :methods => true


  default_scope order('created_at DESC')
  scope :not_superadmin, where(:superadmin => false)

  delegate :name, :to => :department, :prefix => true, :allow_nil => true


  include AASM
  aasm_column :state
  aasm_initial_state :pending
  aasm_state :pending
  aasm_state :actived
  aasm_state :paused
  aasm_state :deleted
  aasm_event :pending do
    transitions :from => :deleted, :to => :pending
  end
  aasm_event :actived do
    transitions :from => [:pending, :paused], :to => :actived
  end
  aasm_event :paused do
    transitions :from => :actived, :to => :paused
  end
  aasm_event :deleted do
    transitions :from => [:pending, :actived, :paused], :to => :deleted
  end


  validates :username, :presence     => true,
                       :uniqueness   => { :case_sensitive => false },
                       :length       => { :within => 4..20 },
                       :format       => { :with => /^[A-Za-z0-9_]+$/ }
  validates :name,     :presence     => true,
                       :length       => { :within => 2..30 }

  class << self
    def current=(user)
      Thread.current[:user] = user
    end

    def current
      Thread.current[:user]
    end
  end

end


# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  roles_mask             :integer         default(0)
#  username               :string(255)
#  superadmin             :boolean         default(FALSE)
#  name                   :string(255)
#  gender                 :string(255)     default("male")
#  phone_number           :string(255)
#  location               :string(255)
#  about                  :text
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  state                  :string(255)     default("pending")
#  department_id          :integer
#

