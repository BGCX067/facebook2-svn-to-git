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
 
class MessageController < ApplicationController
  before_filter :authorize
  layout "main",:except=>"list"
  
  def chat
    @CSSs = ["chat.css","wall.css"]
    @sender=User.find(@params[:id])
    @receiver=User.find(@params[:friend_id])
    @location=@sender.username+" 和 "+@receiver.username+"的对话"
    
    #if there is quote some thing
    if @params[:quote_messageId]!=nil
      @quoteMessage=Message.find(@params[:quote_messageId])
    elsif @params[:quote_postId]!=nil
      @quotePost=Post.find(@params[:quote_postId])
    end
    
    if session[:user].id.to_s!=@params[:id] and session[:user].id.to_s!=@params[:friend_id]
    #not host
      @message_pages, @messages = paginate(  :messages,:per_page => 5, 
                                             :conditions=>["((sender_id=? and receiver_id=?) or (sender_id=? and receiver_id=?)) and isPrivate=false",@params[:id],@params[:friend_id],@params[:friend_id],@params[:id]],
                                             :order => 'sendDatetime desc')
    else
    #is host
      @message_pages, @messages = paginate(  :messages,:per_page => 5, 
                                             :conditions=>["(sender_id=? and receiver_id=?) or (sender_id=? and receiver_id=?)",@params[:id],@params[:friend_id],@params[:friend_id],@params[:id]],
                                             :order => 'sendDatetime desc')
    end
  end
  
  def Send
    @message=Message.new(@params[:message])
    @message.sendDatetime=Time.now
    @message.sender_id=session[:user].id
    if not @message.save
      @location="发送留言"
      @alertMessage="<a href='javascript:history.back(1);'>返回</a><br>发送留言失败，原因如下："
      render(:partial=>"/alertPanel",:layout=>"main")
    else
      redirect_to("/home/index/"+@params[:message][:receiver_id].to_s)
    end    
  end
  
  def sendChatMessage
    @message=Message.new(@params[:message])
    @message.sendDatetime=Time.now
    @message.sender_id=session[:user].id
    @message.save
    redirect_to("/message/chat/"+@message.sender_id.to_s+"?friend_id="+@message.receiver_id.to_s) 
  end
  
  def delete
    Message.delete(@params[:message_id])
    getPager(@params[:receiver_id])
    redirect_to("/home/index/"+@params[:receiver_id])
  end
  
  def deleteChatMessage
    msg = Message.find(@params[:message_id])
    sender_id = msg.sender_id
    Message.delete(@params[:message_id])
    getPager(@params[:id])
    redirect_to("/message/chat/"+@params[:id]+"?friend_id="+sender_id.to_s)
  end

  def getPager(receiver_id)
    @message_pages, @messages = paginate(:messages,:per_page => 5, :conditions => ["receiver_id = ?", receiver_id],:order => 'sendDatetime desc')
  end  
end
