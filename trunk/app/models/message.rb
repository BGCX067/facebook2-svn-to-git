class Message < ActiveRecord::Base
  belongs_to :sender,
             :class_name => "User",
             :foreign_key => "sender_id"
  belongs_to :receiver,
             :class_name => "User",
             :foreign_key => "receiver_id"
  
  belongs_to :quotedMessage,
             :class_name => "Message",
             :foreign_key => "quote_message_id"
  belongs_to :quotedDiary,
             :class_name => "Diary",
             :foreign_key => "quote_diary_id"
  belongs_to :quotedPhoto,
             :class_name => "Photo",
             :foreign_key => "quote_photo_id"
  belongs_to :quotedPost,
             :class_name => "Post",
             :foreign_key => "quote_post_id"

  validates_presence_of :content,
                        :message => "- 请输入留言内容！"
end