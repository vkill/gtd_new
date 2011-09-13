class AddStateBeforeExpiredToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :state_before_expired, :string
  end

  def self.down
    remove_column :issues, :state_before_expired
  end
end
