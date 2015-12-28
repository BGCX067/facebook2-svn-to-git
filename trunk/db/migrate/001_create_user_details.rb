class CreateUserDetails < ActiveRecord::Migration
  def self.up
    create_table :user_details do |t|
    end
  end

  def self.down
    drop_table :user_details
  end
end
