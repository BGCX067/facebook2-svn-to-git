class Photo < ActiveRecord::Base
  has_many :quotingMessages,
           :class_name => "Message",
           :foreign_key => "quote_photo_id"
           
  belongs_to :user
end
