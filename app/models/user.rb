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

