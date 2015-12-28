# Project FaceBook2
# 
# Author: Hlxwell
# 
# Subversion Keywords:
# 
# LastChangedDate: 2007-08-20 12:43:59 +0800 (星期一, 20 八月 2007) 
# LastChangedRevision: 1 
# LastChangedBy: Hlxwell 
# URL: http://facebook2.googlecode.com/svn/trunk/ 
# 
# Copyright (C) 2007 Hlxwell <hlxwell@gmail.com>
# Powered by http://chinaonrails.com
 
class Groupmessage < ActiveRecord::Base
  belongs_to :sender,
             :class_name => "User",
             :foreign_key => "sender_id"
             
  belongs_to :group,
             :foreign_key => "group_id"
             
  belongs_to :quotedMessage,
             :class_name => "Groupmessage",
             :foreign_key => "quote_message_id"
end