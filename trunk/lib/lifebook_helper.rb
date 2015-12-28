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
 
module LifebookHelper
  def uploadZipFile(file)
    fileExt = File.extname(file.original_filename).downcase
    filePath = "#{RAILS_ROOT}/public/uploads_temp/"+getRandomString+fileExt
    
    File.open(filePath, "wb") do |f|
      f.write(file.read)        
    end
    return filePath
  end
  
  def uploadPhotoFile(file,path)
    fileExt = File.extname(file.original_filename).downcase
    filePath = path
    
    File.open(filePath, "wb") do |f|
      f.write(file.read)        
    end
  end
  
  def isHaveSpace(addFilesize)
    #every body get 100M free photo space
    if session[:user].isVIP
      if (getUsedSpace+addFilesize.to_i/1048576)>1000
        return false
      else
        return true
      end
    else
      if (getUsedSpace+addFilesize.to_i/1048576)>100
        return false
      else
        return true
      end
    end
  end
  
  def getUsedSpace
    size = Photo.find_by_sql(["SELECT sum(filesize) as usedSpace FROM photos where user_id=?",session[:user].id.to_s])
    return size[0].usedSpace.to_i/1048576
  end
  
  def getTodayPic(date,user_id)
    return Photo.find(:all,:conditions=>["takeDatetime between ? and ? and user_id=?",date,date+1,user_id],:order=>"takeDatetime asc")
  end
  
  def getTodayPicsNum(date,user_id)
    return Photo.count(["takeDatetime between ? and ? and user_id=?",date,date+1,user_id])
  end
  
  def getTodayPicByNum(date,num,user_id)
    return Photo.find(:all,:limit=>num,:conditions=>["takeDatetime between ? and ? and user_id=?",date,date+1,user_id],:order=>"takeDatetime asc")
  end
  
  def getTotalSpace
    if session[:user].isVIP
      return 1000
    else
      return 100
    end
  end
  
  def getYestodayLink(user_id,today)
    diarys = Diary.find(:all,:conditions=>"user_id="+user_id,:order=>"date desc")
    yestodayIndex = diarys.index(today)-1
    if diarys[yestodayIndex] and yestodayIndex>=0
      return "<a href='/lifebook/day/#{user_id}?diary_id=#{diarys[yestodayIndex].id.to_s}'><#{diarys[yestodayIndex].date.to_s}</a>"
    end
  end
  
  def getTomorrowLink(user_id,today)
    diarys = Diary.find(:all,:conditions=>"user_id="+user_id,:order=>"date desc")
    tomorrowIndex = diarys.index(today)+1
    if diarys[tomorrowIndex]
      return "<a href='/lifebook/day/#{user_id}?diary_id=#{diarys[tomorrowIndex].id.to_s}'>#{diarys[tomorrowIndex].date.to_s}></a>"
    end
  end
  
  def getPhotoPageNumByPhoto(curPhoto,user_id)
    diary = getDiaryByDatetime(curPhoto.takeDatetime,user_id)
    photos = getTodayPic(diary.date,user_id)
    
    pageNum=1
    for photo in photos
      if photo==curPhoto
        break
      end
      pageNum+=1
    end
    
    return pageNum
  end
  
  def getDiaryByDatetime(datetime,user_id)
    date=Time.gm(datetime.year,
                 datetime.month,
                 datetime.day)
    return Diary.find(:first,:conditions=>["date=? and user_id=?",date,user_id])
  end
  
  def getDiaryIdByDatetime(datetime,user_id)
    date=Time.gm(datetime.year,
                 datetime.month,
                 datetime.day)
    diary=Diary.find(:first,:conditions=>["date=? and user_id=?",date,user_id])
    return diary.id
  end
  
  def getNextPage(curPage,pages)
    if pages.page_count==curPage.to_i
      return 1
    else
      return curPage.to_i+1
    end
  end
  #获得照片日记每日的图片所针对的页码，根据当前照片集页码
  def getOffsetPicNumByPageNum(pageNum)
    if pageNum
      return (pageNum.to_i-1)*12
    else
      return 0
    end
  end
end