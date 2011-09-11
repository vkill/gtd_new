class AddAncestryToDepartments < ActiveRecord::Migration
  def self.up
    add_column :departments, :ancestry, :string
  end

  def self.down
    remove_column :departments, :ancestry
  end
end
