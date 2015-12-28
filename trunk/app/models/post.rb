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
 
class Post < ActiveRecord::Base
  belongs_to :poster,
             :class_name => "User",
             :foreign_key => "poster_id"
             
  belongs_to :squareClass,
             :class_name => "Squareclass",
             :foreign_key => "postClass"
             
  validates_presence_of :title,
                        :message => "- 请输入标题！",
                        :on=>:create
  validates_presence_of :content,
                        :message => "- 请输入内容！",
                        :on=>:create 
  has_many :quotingMessages,
           :class_name => "Message",
           :foreign_key => "quote_post_id"
end
