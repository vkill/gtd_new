class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  #easy_roles
  easy_roles :roles_mask, :method => :bitmask
  ROLES_MASK = [:admin, :chief, :staff]
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

