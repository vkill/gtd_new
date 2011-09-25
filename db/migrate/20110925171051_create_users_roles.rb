class CreateUsersRoles < ActiveRecord::Migration
  def self.up
    create_table :users_roles do |t|
      t.references :user
      t.references :role
      t.timestamps
    end
    add_index :users_roles, [:user_id, :role_id]
  end

  def self.down
    drop_table :users_roles
  end
end

