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
end

