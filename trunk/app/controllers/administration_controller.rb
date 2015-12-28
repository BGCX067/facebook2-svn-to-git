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
 
class AdministrationController < ApplicationController
  layout "index"
  
  def addToVip
    if request.post?
      if User.addToVIP(@params[:user][:username])
        render(:text=>"加入VIP成功！<a href='javascript:history.back(1);'>返回</a>",:layout=>"index")
      else
        render(:text=>"加入VIP失败！<a href='javascript:history.back(1);'>返回</a>",:layout=>"index")
      end
    end
  end
end
