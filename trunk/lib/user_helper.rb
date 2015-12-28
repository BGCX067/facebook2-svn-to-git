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
 
module UserHelper
  def authorize
    unless session[:user]
      flash[:alert]="<div class='loginAlert'>您还未登录!</div>"
      redirect_to("/")
    end
  end
  
  def authorizeMenu
    unless session[:user]
      flash[:alert]="<div class='loginAlert'>您还未登录!</div>"   
      render_action "loginForm"
    end
  end
  
  def online?(user_id)    
    sessions = CGI::Session::ActiveRecordStore::Session.find_all

    sessions.each do |s|
      time = Time.now-s.updated_at
      time = time/60
      
      #十分钟清除一次session
      if time>=20
        CGI::Session::ActiveRecordStore::Session.delete(s.id)
      end
      
      #三分钟为过期
#      puts s.data[:user].nil?
#      puts time
#      puts s.data[:user].id.to_s
#      puts user_id.to_s      
      if not s.data[:user].nil? and time<3 and (s.data[:user].id.to_s==user_id.to_s) 
        return "在线"
      else
        return ""
      end
    end
  end
  
  def getUsernameByID(user_id)
    user = User.find(user_id)
    return user.username
  end
  
  def isHost
    if not session[:user]
      return false
    end
    return session[:user].id.to_s==@params[:id]
  end
    
  def isFriend(user_id)
    user=User.find(user_id)
    if session[:user]==user
      return true
    else
      return session[:user].friends.include?(user)
    end
  end
  
  def getFriends
    return session[:user].friends
  end
end