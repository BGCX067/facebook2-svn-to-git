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
 
class Group < ActiveRecord::Base
  has_and_belongs_to_many :members,
                          :class_name=>"User",
                          :foreign_key => "group_id"
                          
  belongs_to :creator,
             :class_name=>"User",
             :foreign_key=>"creator_id"

  validates_presence_of :name,
                        :message => "- 请输入名称！"
  validates_presence_of :interesting,
                        :message => "- 请输入专注方向，并以逗号隔开！"
  validates_presence_of :intro,
                        :message => "- 请输入描述！"
end
