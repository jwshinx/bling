class CreateEndorsements < ActiveRecord::Migration
  def self.up
    create_table :endorsements do |t|
      t.references :endorseable, :polymorphic => true
      t.integer :player_id
      t.string :endorsement_type
      t.integer :cancellation_year 
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :endorsements
  end
end
