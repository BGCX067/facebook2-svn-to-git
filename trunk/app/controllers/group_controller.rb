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
 
class GroupController < ApplicationController
  before_filter :authorize
  layout "group"
  require "RMagick"
  include PhotoHelper
   
  def create
    @CSSs =["group.css","form.css"]
    @location = "新建圈子"
    @currentTab = "create"
  end
  
  def createGroup
    @group = Group.new(@params[:group])
    @group.creator_id = session[:user].id
    @group.bulletin = "欢迎来到"+@group.name
    @group.createDatetime=Time.now
    file=@params[:group][:portrait]
    
    if file.length < 200*1024
      @group.portrait=uploadGroupPortrait("",file)
      if @group.save
        @alertMessage="圈子创建成功！"
      else
        @alertMessage="<a href='javascript:history.back(1);'>返回</a><br>圈子创建失败！失败原因如下："
      end
    else
      @alertMessage="图片不得大于200K！<a href='javascript:history.back(1);'>返回</a>"
    end

    render(:partial=>"/alertPanel",:layout=>"group")
  end
  
  def home
    @CSSs =["group.css","wall.css","lifebook.css"]
    @currentTab = "home"
    @group=Group.find(@params[:id])
    
    #if there is quote some thing
    if @params[:quote_messageId]!=nil
      @quoteMessage=Groupmessage.find(@params[:quote_messageId])
    end
    
    @message_pages, @messages = paginate(:groupmessages,:per_page => 10, :conditions => ["group_id = ?", @params[:id]],:order => 'sendDatetime desc')
    
    getMembersLifebookQuickView
    render(:layout => "groupHome")
  end
  
  def groupMembersLifebook
    @CSSs =["group.css","lifebook.css"]
    getMembersLifebook
    render(:layout => "groupHome")
  end
  
  def list
    @CSSs =["groups.css"]
    @currentTab = "myGroups"
    @location = "我加入的圈子"

    @createdGroups=Group.find(:all,:conditions=>["creator_id=?",@params[:id]])
    @group_pages, @groups = paginate(:groups_users,:per_page => 5,:conditions=>["user_id=?",@params[:id]])

    if @createdGroups.size == 0 and @groups.size == 0
      @alertMessage="暂无加入的圈子！"
      render(:partial=>"/alertPanel",:layout=>"group")
    end
  end
  
  def findGroup
    @CSSs=["groups.css"]
    @currentMenu = "findGroup"
    @location = "查找群组"
    
    keyWord=@params[:group][:keyWord]
    @group_pages, @groups = paginate(:groups,:per_page => 10,:conditions=>"name like '%#{keyWord}%'", :order => 'createDatetime desc')
    render(:action=>"find")
  end
  
  def find
    @CSSs=["groups.css"]
    @currentTab = "find"
    @location = "查找圈子"
    @group_pages, @groups = paginate(:groups,:per_page => 10,:order => 'createDatetime desc')
  end
  
  def members
    @CSSs=["friends.css"]
    @currentTab = "members"
    @group=Group.find(@params[:id])
    @member_pages, @members = paginate(:groupsUsers,:per_page => 10, :conditions => ["group_id = ?", @params[:id]])

    render(:layout => "groupHome")
  end
  
  def editBulletin
    @group=Group.find(@params[:id])
    render_partial "/editGroupBulletin"
  end
  
  def updateBulletin
    @group=Group.find(@params[:id])
    unless @group.update_attributes(@params[:group])
      render_text "修改失败！"
    end
    render_text @group.bulletin
  end
  
  def edit
    @CSSs =["group.css","form.css"]
    @location = "修改圈子信息"
    
    if request.post?
      file=@params[:group][:portrait]    
      @group=Group.find(@params[:id])
      @location=@group.name  
      #超过200K
      if file.length < 200*1024
        #获得上传后的文件名，如果失败会返回老的文件名
        @params[:group][:portrait]=uploadGroupPortrait(@group.portrait,file)
        @group.update_attributes(@params[:group])
        @alertMessage="圈子资料修改成功！"
      else
        @alertMessage="图片不得大于200K！<a href='javascript:history.back(1);'>返回</a>"
      end
      render(:partial=>"/alertPanel",:layout=>"groupHome")
    else
      @group=Group.find(@params[:id])
      render(:layout => "groupHome")
    end
  end
  
  def join
    @location = "加入圈子"
    @currentTab = "find"
    @user=session[:user]
    @group=Group.find(@params[:group_id])
    
    if @group.creator_id==@user.id or @group.members.include?(@user)
      @alertMessage="您已是该圈子成员。"
    else
      @user.groups << @group
      if @user.save
        @alertMessage="圈子加入成功！"
      else
        @alertMessage="圈子加入失败！"
      end
    end    
    render(:partial=>"/alertPanel",:layout=>"group")
  end
  
  def leave
    @location = "退出圈子"
    @currentTab = "myGroups"
    @user=session[:user]
    @group=Group.find(@params[:group_id])
    
    if @group.creator_id==@user.id
      @alertMessage="您是该圈子创建者，所以不能退出。"
    elsif not @group.members.include?(@user)
      @alertMessage="您还不是该圈子成员。"
    elsif
      @user.groups.delete(@group)

      if @user.save
        @alertMessage="退出圈子成功！"
      else
        @alertMessage="退出圈子失败！"
      end
    end
    
    render(:partial=>"/alertPanel",:layout=>"group")
  end
end
