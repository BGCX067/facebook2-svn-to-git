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
 
class SquareController < ApplicationController
  before_filter :authorize
  layout "square/noClassBar"
  
  def getSquareNameByID(id)
    return Squareclass.find(id).name
  end
  
  def index
    @location = getSquareNameByID(@params[:id])
    @currentTab = "allPosts"
    
    case @params[:subClassID]      
      when nil
        conditions=""
        classes = Squareclass.find(:all,:conditions=>["parentClassID=?",@params[:id]])
        for a in classes
          conditions += "postClass = "+a.id.to_s+" or "
        end
        conditions = conditions.chomp(" or ")
        
        @post_pages,@posts = paginate(:posts,:per_page => 20, :conditions => conditions,:order => 'postDatetime desc')
        if @posts.size == 0
          @alertMessage="暂无信息！"  
          render(:partial=>"/alertPanel",:layout=>"square/list")
        else
          render(:layout=>"square/list")
        end
      else
        @post_pages,@posts = paginate(:posts,:per_page => 20, :conditions => ["postClass=?",@params[:subClassID]],:order => 'postDatetime desc')
        if @posts.size == 0
          @alertMessage="暂无信息！"  
          render(:partial=>"/alertPanel",:layout=>"square/list")
        else
          render(:layout=>"square/list")
        end
    end   
  end
  
  def post    
    @currentMenu = "square"    
    @post = Post.find(@params[:id])
    @location = getSquareNameByID(@post.squareClass.parentClassID)
  end

  def myPosts
    @currentMenu = "square"    
    @currentTab = "myPosts"
    
    @location = "我发布的信息"
    @post_pages,@posts = paginate(:posts,:per_page => 20, :conditions => ["poster_id = ?", session[:user].id.to_s],:order => 'postDatetime desc')
    
    if @posts.size == 0
      @alertMessage="暂无发布信息！"
      render(:partial=>"/alertPanel",:layout=>"square/noClassBar")
    end
  end
  
  def add
    post=Post.new(@params[:post])
    post.postDatetime=Time.now
    post.poster_id=session[:user].id
    post.save
    redirect_to(:action=>"index",:id=>@params[:id],:subClassID=>post.postClass)
  end
  
  def addPost
    @CSSs = ["form.css"]
    @currentMenu = "square"
    @currentTab = "addPost"
    @location = getSquareNameByID(@params[:id])+" - 添加信息"
  end
  
  def delete
    Post.delete(@params[:id])
    @alertMessage="删除信息成功！"
    render(:partial=>"/alertPanel",:layout=>"square/noClassBar") 
  end
end
