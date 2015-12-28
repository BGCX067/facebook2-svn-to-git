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
 
class TestController < ApplicationController
  def index
    u = User.new
    #CGI::Session::ActiveRecordStore::Session.delete(:conditions=>["?-updated_at>",Time.now])
    sessions = CGI::Session::ActiveRecordStore::Session.find_all
    sessions.each do |session|
      time = Time.now-session.updated_at
      time=time/60
      puts time.to_s
      if session.data[:user]
        puts session.data[:user][:username]
      end
      if time>10
        CGI::Session::ActiveRecordStore::Session.delete(session.id)
      end
    end
  end
end