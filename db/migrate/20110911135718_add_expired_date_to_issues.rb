class AddExpiredDateToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :expired_date, :datetime
  end

  def self.down
    remove_column :issues, :expired_date
  end
end
