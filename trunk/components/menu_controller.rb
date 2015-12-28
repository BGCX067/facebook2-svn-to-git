class MenuController < ApplicationController
  before_filter :authorizeMenu,:except=>[:homeTabs,:lifebookTabs]
  uses_component_template_root
  
  Link=Struct.new(:title,:url,:current)
  
  def homeTabs
    @user_id=params[:user_id]
    @tabs=Array.new
    @tabs << Link.new("主页","/home/index/"+params[:user_id])
    @tabs << Link.new("好友","/home/friends/"+params[:user_id])
    @tabs << Link.new("圈子","/home/groups/"+params[:user_id])
    @tabs << Link.new("相册","/lifebook/list/"+params[:user_id])

    case params[:currentTab]
      when "home"
        @tabs[0].current=true;
      when "friends"
        @tabs[1].current=true;
      when "groups"
        @tabs[2].current=true;
      when "mine"
        @tabs[3].current=true;
      else
    end
  end
  
  def lifebookTabs
    @tabs=Array.new    
    @tabs << Link.new("我的照片日记","/lifebook/list/"+session[:user].id.to_s)
    @tabs << Link.new("朋友的照片日记","/lifebook/friendLifebooks/"+params[:user_id])
    @tabs << Link.new("添加","/lifebook/add/"+session[:user].id.to_s)
    
    case params[:currentTab]
      when "mine"
        @tabs[0].current=true;
      when "friend"
        @tabs[1].current=true;
      when "add"
        @tabs[2].current=true;
      else
    end
    render_action :tabs
  end
  
  def groupTabs
    @tabs=Array.new    
    @tabs << Link.new("我的圈子","/group/list/"+@session[:user].id.to_s)
    @tabs << Link.new("查找圈子","/group/find/")
    @tabs << Link.new("新建圈子","/group/create/"+@session[:user].id.to_s)
    
    case params[:currentTab]
      when "myGroups"
        @tabs[0].current=true;
      when "find"
        @tabs[1].current=true;
      when "create"
        @tabs[2].current=true;
      else
    end
    render_action :tabs
  end
    
  def groupHomeTabs
    @tabs=Array.new    
    @tabs << Link.new("主页","/group/home/"+params[:group_id])
    @tabs << Link.new("成员","/group/members/"+params[:group_id])
    
    case params[:currentTab]
      when "home"
        @tabs[0].current=true;
      when "members"
        @tabs[1].current=true;
      else
    end
    render_action :tabs
  end
  
  def squareTabs
    @tabs=Array.new    
    @tabs << Link.new("全部信息","/square/index/"+params[:class])
    @tabs << Link.new("发布信息","/square/addPost/"+params[:class])
    @tabs << Link.new("我发布的信息","/square/myPosts/"+params[:class])
    
    case params[:currentTab]
      when "allPosts"
        @tabs[0].current=true;
      when "addPost"
        @tabs[1].current=true;
      when "myPosts"
        @tabs[2].current=true;
      else
    end
    render_action :tabs
  end
  
  def editTabs
    @tabs=Array.new    
    @tabs << Link.new("密码修改","/user/account/")
    @tabs << Link.new("个人资料修改","/user/edit/")
    @tabs << Link.new("隐私权限修改","/user/privacy/")
    
    case params[:currentTab]
      when "account"
        @tabs[0].current=true;
      when "edit"
        @tabs[1].current=true;
      when "privacy"
        @tabs[2].current=true;
      else
    end
    render_action :tabs
  end
  
  def friendTabs
    @tabs=Array.new
    @tabs << Link.new("所有好友","/friend/list/"+session[:user].id.to_s)
    @tabs << Link.new("寻找朋友","/user/find/")
    @tabs << Link.new("在线好友","/user/online/")
    
    case params[:currentTab]
      when "myFriends"
        @tabs[0].current=true;
      when "find"
        @tabs[1].current=true;
      when "online"
        @tabs[2].current=true;
      else
    end
    render_action :tabs
  end
  
  def squareClassTabs
    columns=Squareclass.find(:all,:conditions=>["parentClassID=?",params[:class]])
    @tabs=Array.new
    
    for column in columns
      if params[:currentTab]==column.id.to_s
        @tabs << Link.new(column.name,"/square/index/"+params[:class].to_s+"?subClassID="+column.id.to_s,true)
      else
        @tabs << Link.new(column.name,"/square/index/"+params[:class].to_s+"?subClassID="+column.id.to_s)
      end
    end
  end
  
  def mainMenu
    columns = Squareclass.find(:all,:conditions=>["parentClassID=0"])
    
    @menus=Array.new
    @menus << Link.new("<img src='/img/app_ico/photo.gif' border='0' align='absmiddle'/>照片日记","/lifebook/list/"+session[:user].id.to_s)
    
    for column in columns
      @menus << Link.new("<img src='/img/app_ico/"+column.icon+"' border='0' align='absmiddle'/>"+column.name,"/square/index/"+column.id.to_s)
    end
  end
end