#encoding: utf-8
class UsersRoles < ActiveRecord::Base

  set_table_name "users_roles"

  belongs_to :user
  belongs_to :role

end

