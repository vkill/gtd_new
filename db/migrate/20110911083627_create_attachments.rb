class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :name
      t.text :describtion
      t.string :data_file_name
      t.string :data_content_type
      t.integer :data_file_size
      t.datetime :data_updated_at
      t.integer :download_times, :default => 0
      t.references :attachmentable, :polymorphic => {}

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end

