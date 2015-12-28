class CreateUsersUsers < ActiveRecord::Migration
  def self.up
    create_table :users_users do |t|
    end
  end

  def self.down
    drop_table :users_users
  end
end
