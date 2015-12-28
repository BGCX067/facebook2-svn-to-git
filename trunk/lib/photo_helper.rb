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
 
module PhotoHelper
  def isPhoto(filename)
    ext = File.extname(filename)
    ext = ext.downcase
    if ext==".jpg" or ext==".gif" or ext==".png" or ext==".bmp" or ext==".jpeg"
      return true
    else
      return false
    end
  end
  
  #上传个人头像
  def uploadPersonPortrait(file)
    userPortraitDir="#{RAILS_ROOT}/public/uploads/userPortrait/"
    oldFilename = session[:user].userDetail.portrait
    
    #有文件上传
    if file.length>0
      filename = File.basename(file.original_filename)
      newFilename = getRandomString+File.extname(filename)
      #是图片     
      if isPhoto(filename)
        #delete old file if the old portrait file is exist
        if oldFilename.length > 0
          deleteFile(userPortraitDir+oldFilename)
        end
        #upload new file
        File.open(userPortraitDir+newFilename,'wb') do |f|
          f.puts file.read
        end
        #generate a thumb
        thumb = Magick::Image.read(userPortraitDir+newFilename).first
        width = 240
        height = (thumb.rows*1.00/thumb.columns*1.00)*240
        thumb = thumb.thumbnail(width,height)
        thumb.write(userPortraitDir+newFilename)
        GC.start
        return newFilename
      else
        return oldFilename
      end
    else
      return oldFilename
    end
  end
  
  #上传圈子照片
  def uploadGroupPortrait(portraitFilename,file)
    userPortraitDir="#{RAILS_ROOT}/public/uploads/groupPortrait/"
    
    #有文件上传
    if file.length>0
      filename = File.basename(file.original_filename)
      newFilename = getRandomString+File.extname(filename)
      #是图片     
      if isPhoto(filename)
        #delete old file if the old portrait file is exist
        if portraitFilename.length > 0
          deleteFile(userPortraitDir+portraitFilename)
        end
        #upload new file
        File.open(userPortraitDir+newFilename,'wb') do |f|
          f.puts file.read
        end
        #generate a thumb
        thumb = Magick::Image.read(userPortraitDir+newFilename).first
        width = 240
        height = (thumb.rows*1.00/thumb.columns*1.00)*240
        thumb = thumb.thumbnail(width,height)
        thumb.write(userPortraitDir+newFilename)
        GC.start
        return newFilename
      else
        return portraitFilename
      end
    else
      return portraitFilename
    end
  end

  #删除文件，给定文件地址和文件名
  def deleteFile(filepath)
    if filepath.length>0
      if File.exist?(filepath)
        File.delete(filepath)
      end
    end
  end
  
  #删除照片
  def deleteSavedPhoto(photo)
    originPath = "#{RAILS_ROOT}/public/uploads/origin/#{photo.takeDatetime.strftime('%Y-%m-%d')}/"+photo.filename
    momentViewPath = "#{RAILS_ROOT}/public/uploads/momentView/#{photo.takeDatetime.strftime('%Y-%m-%d')}/"+photo.filename
    thumbPath = "#{RAILS_ROOT}/public/uploads/thumb/#{photo.takeDatetime.strftime('%Y-%m-%d')}/"+photo.filename
    
    deleteFile(originPath)
    deleteFile(momentViewPath)
    deleteFile(thumbPath)
  end
end