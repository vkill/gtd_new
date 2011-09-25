class Role < ActiveRecord::Base

#  has_and_belongs_to_many :users, :join_table => :users_roles
  has_many :users_roles, :class_name => "UsersRoles"
  has_many :users, :through => :users_roles, :uniq => true


  scope :default_scope, order('updated_at DESC')


  validates :code, :presence => true,
                    :uniqueness => true
  validates :name, :presence => true,
                    :uniqueness => true

end

