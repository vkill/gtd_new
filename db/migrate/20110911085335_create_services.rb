class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :name
      t.text :describtion
      t.string :category, :default => 'new_business'
      t.integer :expired_date_hours
      t.references :department

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end

