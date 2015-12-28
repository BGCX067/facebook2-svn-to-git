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
 
class FriendController < ApplicationController
  before_filter :authorize
  layout "friend"
  def list
    @CSSs=["friends.css"]
    @currentTab="myFriends"
    @currentMenu = "home"
    user=User.find(@params[:id])
    @location = user.username+" 的好友"
    
    if isAbleToUse(user,"friend")
      @friend_pages, @fusers = paginate(:users_users,:per_page => 5,:conditions=>["friend_id=?",@params[:id]],:order => 'user_id desc')
      @friends = Array.new
      for user in @fusers
        @friends<<User.find(user.user_id)
      end
      if @friends.size == 0
        @alertMessage="暂无好友！"  
        render(:partial=>"/alertPanel",:layout=>"friend")
      else
        render(:action => "../friend/list",:layout =>"friend")
      end
    else
      @alertMessage="由于"+user.username+"的隐私设置，您无权访问该栏目！"    
      render(:partial=>"/alertPanel",:layout=>"home")
    end
  end
  
  def addFriend
    @location="交朋友"
    @user = User.find(@params[:id])
    @friend = User.find(@params[:friend_id])
    
    if @params[:friend_id]==@params[:id]
      @alertMessage = "不能加自己为好友!"
    elsif @user.friends.include?(@friend)
      @alertMessage = "<b>"+@friend.username+"</b>已经是好友!"
    else
      @user.friends << @friend
      @user.save
      @alertMessage = "添加好友<b>"+@friend.username+"</b>成功! <a href='/home/index/"+@params[:friend_id]+"'>去对方主页看看</a>"
    end
    
    render(:partial=>"/alertPanel",:layout=>"friend")
  end
  
  def delete
    @location="跟朋友感情破裂了"
    @user = User.find(@params[:id])
    @friend = User.find(@params[:friend_id])
    
    if @user.friends.include?(@friend)
      @user.friends.delete(@friend)
      @alertMessage = "删除好友<b>"+@friend.username+"</b>成功!"
    else
      @alertMessage = "<b>"+@friend.username+"</b> 还不是我朋友!"
    end
    render(:partial=>"/alertPanel",:layout=>"friend")
  end
end