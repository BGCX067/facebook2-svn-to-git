class Diary < ActiveRecord::Base
  has_many :quotingMessages,
           :class_name => "Message",
           :foreign_key => "quote_diary_id"
           
  belongs_to :user
end
