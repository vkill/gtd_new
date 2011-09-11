class CreateEvaluations < ActiveRecord::Migration
  def self.up
    create_table :evaluations do |t|
      t.string :category
      t.integer :star_rating
      t.references :evaluationable, :polymorphic => {}

      t.timestamps
    end
  end

  def self.down
    drop_table :evaluations
  end
end

