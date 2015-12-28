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
 
class BlogController < ApplicationController
  before_filter :authorize
  include Leftbee::HTMLHelpers
  layout "home"
  
  def show
    @CSSs=["blog.css","form.css"]
    user = User.find(@params[:id])
    @location = user.username+" 的博客"
    
    if @params[:blog_id]
      @blog = Blog.find(@params[:blog_id])
    end
  end
  def edit
    @CSSs=["blog.css","form.css"]
    user = User.find(@params[:id])
    @location = user.username+" 的博客"
    
    if @params[:blog_id]
      @blog = Blog.find(@params[:blog_id])
    end
    
    if @params[:blog]
      Blog.update(@params[:blog_id],
                  :title=>@params[:blog][:title],
                  :content=>@params[:blog][:content],
                  :isPrivate=>@params[:blog][:isPrivate])
      redirect_to :controller=>:home,:action=>:index,:id=>@params[:id]
    end
  end
  
  def write
    @CSSs=["blog.css","form.css"]
    user = User.find(@params[:id])
    @location = user.username+" 的博客"
    
    if @params[:blog]
      blog = Blog.new(@params[:blog])
      blog.writeDatetime=Time.now
      blog.user_id=session[:user].id
      blog.save
      
      redirect_to :controller=>:home,:action=>:index,:id=>@params[:id]
    end
  end
  def delete
    Blog.delete(@params[:blog_id])
    redirect_to :controller=>:home,:action=>:index,:id=>@params[:id]
  end
end
