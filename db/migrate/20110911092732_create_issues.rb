class CreateIssues < ActiveRecord::Migration
  def self.up
    create_table :issues do |t|
      t.text :body
      t.string :state, :default => "pending"
      t.integer :assigner_id
      t.integer :accepter_id
      t.text :assign_remark
      t.datetime :assign_at
      t.text :solution
      t.datetime :accept_at
      t.text :result
      t.datetime :finish_at
      t.references :user
      t.references :service
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :issues
  end
end

