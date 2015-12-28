class CreateSquareclasses < ActiveRecord::Migration
  def self.up
    create_table :squareclasses do |t|
    end
  end

  def self.down
    drop_table :squareclasses
  end
end
