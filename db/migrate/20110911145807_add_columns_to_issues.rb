class AddColumnsToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :name, :string
    add_column :issues, :start_at, :datetime
    add_column :issues, :end_at, :datetime
  end

  def self.down
    remove_column :issues, :end_at
    remove_column :issues, :start_at
    remove_column :issues, :name
  end
end
