class Blog < ActiveRecord::Base
  belongs_to :writer,
             :class_name => "User",
             :foreign_key => "user_id"
end
