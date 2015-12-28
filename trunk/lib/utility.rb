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
 
module Utility
  def isPrivate(isprivate)
    if isprivate
      return " - <strong>私密</strong>"    
    end
  end
  
  def getSquareColumnsWhenAdding(id)
    columns = Squareclass.find(:all,:conditions=>["parentClassID=?",id],:order=>"id desc")
    cols=Hash.new()
    for column in columns
      cols[column.name]=column.id
    end
    return cols
  end
  
  def getRandomString(length=30)
    chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
    str = ''
    length.downto(1) { |i| str << chars[rand(chars.length - 1)] }
    return str
  end  
end