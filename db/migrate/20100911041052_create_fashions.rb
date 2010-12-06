class CreateFashions < ActiveRecord::Migration
  def self.up
    create_table :fashions do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :fashions
  end
end
