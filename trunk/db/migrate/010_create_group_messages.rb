class CreateGroupMessages < ActiveRecord::Migration
  def self.up
    create_table :group_messages do |t|
    end
  end

  def self.down
    drop_table :group_messages
  end
end
