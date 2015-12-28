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
 
class User < ActiveRecord::Base
  has_one :userDetail
  has_many :sentMessages,
           :class_name => "Message",
           :foreign_key => "sender_id"

  has_many :receivedMessages,
           :class_name => "Message",
           :foreign_key => "receiver_id"
           
  has_many :blogs
           
  has_and_belongs_to_many :groups,
                          :foreign_key => "user_id"
                          
  has_and_belongs_to_many :friends,
                          :class_name => "User",
                          :foreign_key => "friend_id"
  
  validates_presence_of :username,
                        :message => "- 请输入用户名！",
                        :on=>:create
                        
  validates_presence_of :password,
                        :message => "- 请输入密码！",
                        :on=>:create

  validates_confirmation_of :password,
                            :message => "- 两次密码输入不一致！",
                            :on=>:create
                            
  validates_presence_of :email,
                        :message => "- 请输入email！",
                        :on=>:create
                        
  validates_uniqueness_of :username,
                          :message => "- 用户名已经存在！",
                          :on=>:create
                          
  validates_format_of :email,
                      :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
                      :message => "- email地址错误！",
                      :on=>:create               
  
  validates_associated :userDetail,
                       :message=>"- 用户详情输入错误！",
                       :on=>:create

  def before_create
    self.registerDatetime=Time.now
    self.userDetail.portrait=""
  end
  
  def self.areFriends?(user_id1,user_id2)
    user1=User.find(user_id1)
    user2=User.find(user_id2)    
    return user1.friends.include?(user2)
  end
  
  def self.isMyfriend?(user)
    if self==user
      return true
    else
      return session[:user].friends.include?(user)
    end
  end
  
  def self.login(username, password)
    #hashed_password = hash_password(password)
    if username==""
      return "<div class='loginAlertPanel'>请输入用户名</div>"
    elsif not User.find_by_username(username)
      return "<div class='loginAlertPanel'>用户名错误！</div>"
    elsif not User.find_by_username_and_password(username,password)
      return "<div class='loginAlertPanel'>密码错误！</div>"
    else
      return "<div class='loginAlertPanel'>登录成功！</div><script>location='/home?id="+User.find_by_username(username).id.to_s+"';</script>"
    end
  end

  def self.addToVIP(username)
    user = User.find_by_username(username)
    user.isVIP=true

    if user.save
      return true
    else
      return false
    end
  end
end