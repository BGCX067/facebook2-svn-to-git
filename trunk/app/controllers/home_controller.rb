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
 
class HomeController < ApplicationController
  before_filter :authorize
  layout "home"
  
  #我可以保持HOME这个Layout然后中间仍然显示其他action
  def index    
    @user=User.find(@params[:id])
    @CSSs = ["home.css","wall.css","blog.css","lifebook.css"]
    @currentMenu = "home"
    @currentTab = "home"
    @location = @user.username+" 的主页"   
    
    @newDiaries = Diary.find(:all,:limit=>2,:conditions=>["user_id=?",@params[:id]],:order=>"date desc")

    #read the messages
    if session[:user].id.to_s!=@params[:id]
      #not host,hide some private message
      @message_pages, @messages = paginate( :messages,:per_page => 10, 
                                            :conditions => ["receiver_id = ? and (isPrivate=false or sender_id=?)", @params[:id],session[:user].id],
                                            :order => "sendDatetime desc")
                                            
      #read the blogs
      @blog_pages, @blogs = paginate( :blogs,:per_page => 5, 
                                      :conditions => ["user_id = ? and isPrivate=false", @params[:id]],
                                      :order => "writeDatetime desc",
                                      :parameter => "blogPage" )
    else
      #is host,show all
      @message_pages, @messages = paginate( :messages,:per_page => 10, 
                                            :conditions => ["receiver_id = ?", @params[:id]],
                                            :order => "sendDatetime desc")
      #read the blogs
      @blog_pages, @blogs = paginate( :blogs,:per_page => 5, 
                                      :conditions => ["user_id = ?", @params[:id]],
                                      :order => "writeDatetime desc",
                                      :parameter => "blogPage" )
    end    
  end
  
  def friends
    @CSSs=["friends.css"]
    @currentTab="friends"
    @currentMenu = "home"
    user=User.find(@params[:id])
    @location = user.username+" 的好友"
    #@friends = User.find(@params[:id]).friends
    #@friends = User.find_all
    
    if isAbleToUse(user,"friend")
      @friend_pages, @fusers = paginate(:users_users,:per_page => 5,:conditions=>["friend_id=?",@params[:id]],:order => 'user_id desc')
      @friends = Array.new
      for user in @fusers
        @friends<<User.find(user.user_id)
      end
      
      if @friends.size == 0
        @alertMessage="暂无好友！"  
        render(:partial=>"/alertPanel",:layout=>"home")
      else
        render(:action => "../friend/list",:layout =>"home")
      end
    else
      @alertMessage="由于"+user.username+"的隐私设置，您无权访问该栏目！"    
      render(:partial=>"/alertPanel",:layout=>"home")
    end    
  end
  
  def groups
    @CSSs=["groups.css"]
    @currentTab="groups"
    user=User.find(@params[:id])
    @location = user.username+" 的圈子"
    
    if isAbleToUse(user,"group")
      @createdGroups=Group.find(:all,:conditions=>["creator_id=?",@params[:id]])
      @group_pages, @groups = paginate(:groups_users,:per_page => 5,:conditions=>["user_id=?",@params[:id]])
      
      if @createdGroups.size == 0 and @groups.size == 0
        @alertMessage="暂无加入任何圈子！"
        render(:partial=>"/alertPanel",:layout=>"home")
      else
        render(:action => "../group/list", :layout => "home")
      end
    else
      @alertMessage="由于"+user.username+"的隐私设置，您无权访问该栏目！"    
      render(:partial=>"/alertPanel",:layout=>"home")
    end
  end
end
