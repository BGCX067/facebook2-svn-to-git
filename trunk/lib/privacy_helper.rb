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
 
module PrivacyHelper  
  def isAbleToUse(user,function)
    if not session[:user] and user.userDetail.lifebookPrivacy=="all"
      return true
    end
    
    isfriend=isFriend(user.id)
    case function
      when "profile"
        if isHost or user.userDetail.profilePrivacy=="all" or (user.userDetail.profilePrivacy=="friend" and isfriend)
          return true
        else
          return false
        end
      when "lifebook"
        if isHost or user.userDetail.lifebookPrivacy=="all" or (user.userDetail.lifebookPrivacy=="friend" and isfriend)
          return true
        else
          return false
        end
      when "friend"
        if isHost or user.userDetail.friendPrivacy=="all" or (user.userDetail.friendPrivacy=="friend" and isfriend)
          return true
        else
          return false
        end
      when "group"
        if isHost or user.userDetail.groupPrivacy=="all" or (user.userDetail.groupPrivacy=="friend" and isfriend)
          return true
        else
          return false
        end
      when "message"
        if isHost or user.userDetail.messagePrivacy=="all" or (user.userDetail.messagePrivacy=="friend" and isfriend)
          return true
        else
          return false
        end
      else
        return false
    end
  end
end