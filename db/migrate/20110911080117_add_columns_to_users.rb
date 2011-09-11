class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    add_column :users, :superadmin, :boolean, :default => false
    add_column :users, :name, :string
    add_column :users, :gender, :string, :default => "male"
    add_column :users, :phone_number, :string
    add_column :users, :location, :string
    add_column :users, :about, :text
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :integer
    add_column :users, :avatar_updated_at, :datetime
    add_column :users, :state, :string, :default => "pending"
    add_column :users, :department_id, :integer
  end

  def self.down
    remove_column :users, :department_id
    remove_column :users, :state
    remove_column :users, :avatar_updated_at
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_name
    remove_column :users, :about
    remove_column :users, :location
    remove_column :users, :phone_number
    remove_column :users, :gender
    remove_column :users, :name
    remove_column :users, :superadmin
  end
end

