class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.string :category, :default => 'bad'
      t.text :body
      t.string :state, :default => 'pending'
      t.text :result
      t.integer :handler_id
      t.datetime :handle_at
      t.references :issue

      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end

