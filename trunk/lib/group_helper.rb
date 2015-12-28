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
 
module GroupHelper
  def isCreator
    return session[:user].id==Group.find(@params[:id]).creator.id
  end
  def isCreatorByGroup(group)
    return session[:user].id==Group.find(group.id).creator.id
  end
  def isJoinedGroup(group)
    if group.members.include?(session[:user])
      return true
    else
      return false
    end
  end
  def getMembersLifebook(num = 0)
    group=Group.find(@params[:id])
    members=group.members
    
    if members.size>0
      conditions=""    
      for member in members
        conditions+="user_id="+member.id.to_s+" or "
      end
      conditions+=group.creator.id.to_s
      if num!=0
        @diary_pages, @diaries = paginate(:diaries, :per_page => num, :conditions => conditions,:order => 'date desc')
      else
        @diary_pages, @diaries = paginate(:diaries, :per_page => 5, :conditions => conditions,:order => 'date desc')
      end
    end
  end
  def getMembersLifebookQuickView
    group=Group.find(@params[:id])
    members=group.members
    
    if members.size>0
      conditions=""    
      for member in members
        conditions+="user_id="+member.id.to_s+" or "
      end
      conditions+=group.creator.id.to_s
      @diary_pages, @diaries = paginate(:diaries, :per_page => 2, :conditions => conditions,:order => 'date desc')
    end
  end
end