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
                    :default_url => "/images/profile-avatar.jpg"
  validates_attachment_size :avatar, :less_than => 2.megabytes


  #easy_roles
  easy_roles :roles_mask, :method => :bitmask
  ROLES_MASK = %w(admin chief staff)
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES_MASK.index(role.to_s)} > 0 "} }


  belongs_to :department
  has_many :posts
  has_many :softwares
  has_many :businesses
  has_many :tasks
  has_many :assign_businesses, :foreign_key => :assigner_id, :class_name => "Business"
  has_many :accept_businesses, :foreign_key => :accepter_id, :class_name => "Business"
  has_many :assign_tasks, :foreign_key => :assigner_id, :class_name => "Task"
  has_many :accept_tasks, :foreign_key => :accepter_id, :class_name => "Task"
  has_many :handle_feedbacks, :foreign_key => :handler_id, :class_name => "Feedback"

  symbolize :gender, :in => [ :male, :female ], :scopes => true, :methods => true
  symbolize :state, :in => [ :pending, :actived, :paused, :deleted ], :scopes => true, :methods => true

end

