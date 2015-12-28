class CreateDiaries < ActiveRecord::Migration
  def self.up
    create_table :diaries do |t|
    end
  end

  def self.down
    drop_table :diaries
  end
end
