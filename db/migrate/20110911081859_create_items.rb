class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.string :permalink
      t.text :content
      t.boolean :top, :default => false
      t.string :category, :default => 'none'
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end

