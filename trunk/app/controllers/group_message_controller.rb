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
 
class GroupMessageController < ApplicationController
  before_filter :authorize
  def Send
    @message=Groupmessage.new(@params[:message])
    @message.sendDatetime=Time.now
    @message.sender_id=session[:user].id
    @message.save
    redirect_to("/group/home/"+@params[:message][:group_id].to_s)
  end

  def delete
    Groupmessage.delete(@params[:message_id])
    redirect_to("/group/home/"+@params[:group_id])
  end
end
