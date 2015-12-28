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
 
class UserController < ApplicationController
  before_filter :authorize,:except=>[:register,:create,:login]
  layout "main"
  require "RMagick"

  def online
    @CSSs=["friends.css"]
    @location="在线用户"
    @currentTab="online"
    @onlineUsers=Array.new
    
    sessions = CGI::Session::ActiveRecordStore::Session.find_all
    sessions.each do |s|
      time = Time.now-s.updated_at
      time = time/60
      
      #十分钟清除一次session
      if time>=20
        CGI::Session::ActiveRecordStore::Session.delete(s.id)
      end
      
      #三分钟为过期
      if time<3 and s.data[:user] and (s.data[:user]!=session[:user]) and isFriend(s.data[:user][:id])
        #不让重复session加入
        if not @onlineUsers.include?(s.data[:user])
          @onlineUsers << s.data[:user]
        end
      end
    end
        
    if @onlineUsers.size<=0
      @alertMessage="没有在线用户！"
      render(:partial=>"/alertPanel",:layout=>"friend")
    else
      render(:layout=>"friend")
    end
  end
  
  def find
    @CSSs=["friends.css"]
    @currentTab = "find"
    @location = "查找用户"

    if request.post?
      @users_pages, @users = paginate(:users,:per_page => 10,:conditions=>"username like '%#{@params[:user][:keyWord]}%'", :order => 'id desc')
    else
      @users_pages, @users = paginate(:users,:per_page => 10,:order => 'id desc')
    end
    
    render(:layout=>"friend")    
  end

  def register
    @CSSs=["index.css","form.css"]
    @location = "快速注册"
  end
  
  def create 
    @user = User.new(@params[:user])
    @userDetail = UserDetail.new(@params[:userDetail])
    @user.userDetail = @userDetail
    
    if @user.save and @userDetail.save
      @alertMessage="恭喜您，注册成功！<script>location='/'</script>"
    else
      @alertMessage="注册失败！"
    end
    render_partial "/alertPanel"
  end
  
  def account
    @CSSs=["form.css"]
    @location = "帐户修改"
    @currentTab = "account"
    render(:layout=>"edit")
  end
  
  def updatePassword
    @user = session[:user]

    if @user.password!=@params[:oldUser][:password]
      @alertMessage="- 原密码不正确！"
    else
      if @params[:user][:password].length==0
        @alertMessage="- 请输入密码！"
      elsif @params[:user][:password]!=@params[:user][:password_confirmation]
        @alertMessage="- 两次密码输入不正确！"
      elsif @user.update_attributes(@params[:user])
        @alertMessage="密码修改成功！"
      end
    end
    
    render(:partial=>"/alertPanel")
  end

  def privacy
    @CSSs=["form.css"]
    @currentTab = "privacy"
    @location = "隐私修改"
    @userDetail=session[:user].userDetail
    render(:layout=>"edit")
  end
  
  def privacyUpdate
    @location = "隐私修改"    
    session[:user].userDetail.update_attributes(@params[:userDetail])
    @alertMessage="隐私设置修改成功！"    
    render(:partial=>"/alertPanel")
  end
  
  def edit
    @CSSs=["form.css"]
    @currentTab = "edit"
    @location = "个人资料修改"
    @userDetail=session[:user].userDetail
    render(:layout=>"edit")
  end
  
  def updateProfile
    @location = "个人资料修改"
    @currentTab = "edit"
    file=@params[:userDetail][:portrait]
    @userDetail = session[:user].userDetail
    
    #超过200K
    if file.length < 200*1024
      #获得上传后的文件名，如果失败会返回老的文件名
      @params[:userDetail][:portrait]=uploadPersonPortrait(file)
      if @userDetail.update_attributes(@params[:userDetail])
        @alertMessage="用户资料修改成功！"
      else
        @alertMessage="<a href='javascript:history.back(1);'>返回</a><br>用户资料修改失败！原因如下"
      end
    else
      @alertMessage="图片不得大于200K！<a href='javascript:history.back(1);'>返回</a>"
    end
    
    render(:partial=>"/alertPanel",:layout=>"edit")
  end
    
  def login    
    @alertMessage = User.login(@params[:user][:username],@params[:user][:password])
    if @alertMessage.include?("登录成功")
      session[:user]=User.find_by_username(@params[:user][:username])
    end
    render_text @alertMessage
  end
  
  def logout
    reset_session
    redirect_to "/"
  end
end