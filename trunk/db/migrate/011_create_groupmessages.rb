class CreateGroupmessages < ActiveRecord::Migration
  def self.up
    create_table :groupmessages do |t|
    end
  end

  def self.down
    drop_table :groupmessages
  end
end
