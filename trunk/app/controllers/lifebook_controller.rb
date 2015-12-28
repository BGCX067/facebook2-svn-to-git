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
 
class LifebookController < ApplicationController
  before_filter :authorize,:except=>[:list,:day,:moment,:progress]
  session :off, :only => :progress
  layout "lifebook"
  require "zip/zip"
  require "fileutils"
  require "RMagick"
  require "image_magick_extensions"
  
  def progress
    if @status = Mongrel::Uploads.check(params[:upload_id])
      render :update do |page|              
        if (@status[:received]*1.00/@status[:size]*1.00)>=0.98
          page.upload_progress.processFile
        else
          page.upload_progress.update @status[:size], @status[:received]  
        end
      end
    end
  end
  def add
    @CSSs=["lifebook.css","form.css"]
    @currentTab = "add"    
    @location = "<img src='/img/app_ico/photo.gif' border='0' align='absmiddle'/>我的照片日记 - 添加"  
  end
  def list
    @CSSs=["lifebook.css"]
    @currentTab = "mine"
    @location = "<img src='/img/app_ico/photo.gif' border='0' align='absmiddle'/>照片日记 - 记录生命"

    user=User.find(@params[:id])
    @allDiaries=Diary.find(:all,:conditions=>["user_id=?",@params[:id]],:order=>"date desc")
    if isAbleToUse(user,"lifebook")
      @diary_pages, @diaries = paginate(:diaries,:per_page => 5, :conditions => ["user_id = ?", @params[:id]],:order => 'date desc')
      
      if isHost
        if @diaries.size == 0
          @alertMessage="暂无照片日记！"
          render(:partial=>"/alertPanel",:layout=>"lifebook")
        end
      else
        if @diaries.size == 0
          @alertMessage="暂无照片日记！"
          render(:partial=>"/alertPanel",:layout=>"home")
        else
          render(:layout=>"home")
        end
      end
    else
      @alertMessage="由于"+user.username+"的隐私设置，您无权访问该栏目！"    
      render(:partial=>"/alertPanel")
    end
  end
  
  def friendLifebooks
    @CSSs=["lifebook.css"]
    @currentTab = "friend"
    @location = "<img src='/img/app_ico/photo.gif' border='0' align='absmiddle'/>照片日记 - 记录生命"

    friends=session[:user].friends
    
    if friends.size>0
      conditions=""    
      for friend in friends
        conditions+="user_id="+friend.id.to_s+" or "
      end
      conditions=conditions.chomp(" or ")
      @diary_pages, @diaries = paginate(:diaries,:per_page => 5, :conditions => conditions,:order => 'date desc')
      puts @diaries.size.to_s
      if @diaries.size == 0
          @alertMessage="好友暂无照片日记！"
          render(:partial=>"/alertPanel",:layout=>"lifebook")
      end
    else
      @alertMessage="暂无好友！"
      render(:partial=>"/alertPanel",:layout=>"lifebook")
    end
  end
  def day
    @CSSs=["lifebook.css","wall.css"]
    @location = "<img src='/img/app_ico/photo.gif' border='0' align='absmiddle'/>照片日记 - 记录生命"
    if isHost
        @currentTab = "mine"
    else
        @currentTab = "friend"
    end

    @diary=Diary.find(@params[:diary_id])
    @photo_pages, @photos = paginate(:photos,:per_page => 12, :conditions => ["user_id = ? and (takeDatetime between ? and ?)", @params[:id],@diary.date,@diary.date+1],:order=>"takeDatetime asc")
  end
  def moment
    @CSSs=["lifebook.css","wall.css"]
    @location = "照片日记 - 记录生命"
    if isHost
        @currentTab = "mine"
    else
        @currentTab = "friend"
    end
    @diary=Diary.find(@params[:diary_id])
    @photo_pages, @photos = paginate(:photos,:per_page => 1, :conditions => ["user_id = ? and (takeDatetime between ? and ?)", @params[:id],@diary.date,@diary.date+1],:order=>"takeDatetime asc")
  end
  def upload
    file = @params["file"]
    fileName = File.basename(file.original_filename)
    fileExt = File.extname(file.original_filename).downcase
    #是否有空间
    if isHaveSpace(file.size)
      #是ZIP包
      if fileExt == ".zip"
        #上传文件
        uploadFilename=uploadZipFile(file)
        #解压文件 rubyzip version
        takeDates=Array.new #所有不重复的拍照日期，作为日记日期用。     
        Zip::ZipFile::open(uploadFilename) { |zf|  
          zf.each { |e|                            
            #if is photo
            if isPhoto(e.name)
              newfilename=getRandomString+File.extname(e.name)
              tempImg="#{RAILS_ROOT}/public/uploads_temp/#{newfilename}"
              e.extract(tempImg)

              #获得拍摄日期
              image = Magick::Image.read(tempImg).first
              if image.exif(:include => ["DateTimeOriginal"]).to_s.length>0
                newTime = image.exif(:include => ["DateTimeOriginal"]).delete("DateTimeOriginal")
                photoTakeDatetime=newTime.asctime
                photoTakeDate=newTime.strftime('%Y-%m-%d')
              else
                photoTakeDatetime=e.mtime
                photoTakeDate=photoTakeDatetime.strftime('%Y-%m-%d')
              end  
              #delete temp file
              File.delete(tempImg)
              
              #make directory(like 2006-09-14) if it is not exist
              if not File.exist?("#{RAILS_ROOT}/public/uploads/origin/#{photoTakeDate}")
                Dir.mkdir("#{RAILS_ROOT}/public/uploads/origin/#{photoTakeDate}")
                Dir.mkdir("#{RAILS_ROOT}/public/uploads/momentView/#{photoTakeDate}")
                Dir.mkdir("#{RAILS_ROOT}/public/uploads/thumb/#{photoTakeDate}")
              end
              newOriginFPath="#{RAILS_ROOT}/public/uploads/origin/#{photoTakeDate}/#{newfilename}"
              newMomentFPath="#{RAILS_ROOT}/public/uploads/momentView/#{photoTakeDate}/#{newfilename}"
              newThumbFPath="#{RAILS_ROOT}/public/uploads/thumb/#{photoTakeDate}/#{newfilename}"
                            
              #save the file to the origin folder
              if not e.is_directory() 
                e.extract(newOriginFPath)
              end
              
              #moment view photo
              moment   = Magick::Image.read(newOriginFPath).first
              width=610
              height=(moment.rows*1.00/moment.columns*1.00)*width
              moment   = moment.thumbnail(width,height)    
              moment.write(newMomentFPath)
              
              #thumb photo(edit from newMomentFPath)
              thumb   = Magick::Image.read(newMomentFPath).first
              width=135
              height=(thumb.rows*1.00/thumb.columns*1.00)*width
              thumb = thumb.thumbnail(width,height)    
              thumb.write(newThumbFPath)
              
              #添加照片信息入数据库
              photo=Photo.new           
              #for no repeating photo datetime
              if Photo.find_by_takeDatetime(photoTakeDatetime)
                photo.takeDatetime=photoTakeDatetime+1
              else
                photo.takeDatetime=photoTakeDatetime
              end
              photo.filesize=File.size(newOriginFPath)
              photo.description=""
              photo.filename = newfilename
              photo.user_id = session[:user].id
              photo.save
              
              newTakeDate = Time.gm(photo.takeDatetime.year,
                                    photo.takeDatetime.month,
                                    photo.takeDatetime.day)
              #judge if we need add a new take time
              if (not takeDates.include?(newTakeDate)) and getDiaryByDatetime(photo.takeDatetime,session[:user].id).nil?
                #add to diary
                diary = Diary.new
                diary.date = newTakeDate
                diary.user_id = session[:user].id
                diary.save
              end
              GC.start
            end #end of isPhoto
          }
        }
        
        #delete zip file
        File.delete(uploadFilename)
        render(:text=>"<script type='text/javascript'>window.parent.UploadProgress.finish();window.parent.alertPanel.innerHTML='<div class=alertPanel>上传成功，请赶紧去发现精彩吧！<a href=/lifebook/list/#{@session[:user].id}>查看</a></div>';</script>")
      #是图片
      elsif isPhoto(fileName)
        #先解压
        newfilename=getRandomString+fileExt
        tempImg="#{RAILS_ROOT}/public/uploads_temp/#{newfilename}"
        uploadPhotoFile(file,tempImg)
        
        #获得拍摄日期
        image = Magick::Image.read(tempImg).first
        if image.exif(:include => ["DateTimeOriginal"]).to_s.length>0
          newTime = image.exif(:include => ["DateTimeOriginal"]).delete("DateTimeOriginal")
          photoTakeDatetime=newTime.asctime
          photoTakeDate=newTime.strftime('%Y-%m-%d')
        else
          photoTakeDatetime=file.mtime
          photoTakeDate=photoTakeDatetime.strftime('%Y-%m-%d')
        end
        
        #make directory(like 2006-09-14) if it is not exist
        if not File.exist?("#{RAILS_ROOT}/public/uploads/origin/#{photoTakeDate}")
          Dir.mkdir("#{RAILS_ROOT}/public/uploads/origin/#{photoTakeDate}")
          Dir.mkdir("#{RAILS_ROOT}/public/uploads/momentView/#{photoTakeDate}")
          Dir.mkdir("#{RAILS_ROOT}/public/uploads/thumb/#{photoTakeDate}")
        end
        newOriginFPath="#{RAILS_ROOT}/public/uploads/origin/#{photoTakeDate}/#{newfilename}"
        newMomentFPath="#{RAILS_ROOT}/public/uploads/momentView/#{photoTakeDate}/#{newfilename}"
        newThumbFPath="#{RAILS_ROOT}/public/uploads/thumb/#{photoTakeDate}/#{newfilename}"
        
        #save the file to the origin folder
        File.copy(tempImg, newOriginFPath)
        
        #moment view photo
        moment   = Magick::Image.read(newOriginFPath).first
        width=610
        height=(moment.rows*1.00/moment.columns*1.00)*width
        moment   = moment.thumbnail(width,height)    
        moment.write(newMomentFPath)
        
        #thumb photo(edit from newMomentFPath)
        thumb   = Magick::Image.read(newMomentFPath).first
        width=135
        height=(thumb.rows*1.00/thumb.columns*1.00)*width
        thumb = thumb.thumbnail(width,height)    
        thumb.write(newThumbFPath)
        
        #record the photo info
        photo=Photo.new           
        #for no repeating photo datetime
        if Photo.find_by_takeDatetime(photoTakeDatetime)
          photo.takeDatetime=photoTakeDatetime+1
        else
          photo.takeDatetime=photoTakeDatetime
        end
        photo.filesize=File.size(newOriginFPath)
        photo.description=""
        photo.filename = newfilename
        photo.user_id = session[:user].id
        photo.save
        
        newTakeDate = Time.gm(photo.takeDatetime.year,
                              photo.takeDatetime.month,
                              photo.takeDatetime.day)
        #judge if we need add a new take time
        if getDiaryByDatetime(photo.takeDatetime,session[:user].id).nil?
          #add to diary
          diary = Diary.new
          diary.date = newTakeDate
          diary.user_id = session[:user].id
          diary.save
        end
        GC.start
        #succeed
        render(:text=>"<script type='text/javascript'>window.parent.UploadProgress.finish();window.parent.alertPanel.innerHTML='<div class=alertPanel>上传成功，请赶紧去发现精彩吧！<a href=/lifebook/list/#{@session[:user].id}>查看</a></div>';</script>")
      else #wrong file type
        render(:text=>"<script type='text/javascript'>window.parent.UploadProgress.finish();window.parent.alertPanel.innerHTML='<div class=alertPanel>只能上传zip,jpg,gif,png,bmp文件！</div>';</script>")
      end
    else #no space
      render(:text=>"<script type='text/javascript'>window.parent.UploadProgress.finish();window.parent.alertPanel.innerHTML='<div class=alertPanel>您的空间不足，请购买空间！</div>';</script>")
    end  
  end
  def uploadPic
    file = @params[:Filedata]
    
    if file
      fileName = File.basename(file.original_filename)
      fileExt = File.extname(file.original_filename).downcase
      newfilename=getRandomString+fileExt
      tempImg="#{RAILS_ROOT}/public/uploads_temp/#{newfilename}"
      uploadPhotoFile(file,tempImg)
      
      #获得拍摄日期
      image = Magick::Image.read(tempImg).first
      if image.exif(:include => ["DateTimeOriginal"]).to_s.length>0
        newTime = image.exif(:include => ["DateTimeOriginal"]).delete("DateTimeOriginal")
        photoTakeDatetime=newTime.asctime
        photoTakeDate=newTime.strftime('%Y-%m-%d')
      else
        photoTakeDatetime=file.mtime
        photoTakeDate=photoTakeDatetime.strftime('%Y-%m-%d')
      end
      
      #make directory(like 2006-09-14) if it is not exist
      if not File.exist?("#{RAILS_ROOT}/public/uploads/origin/#{photoTakeDate}")
        Dir.mkdir("#{RAILS_ROOT}/public/uploads/origin/#{photoTakeDate}")
        Dir.mkdir("#{RAILS_ROOT}/public/uploads/momentView/#{photoTakeDate}")
        Dir.mkdir("#{RAILS_ROOT}/public/uploads/thumb/#{photoTakeDate}")
      end
      newOriginFPath="#{RAILS_ROOT}/public/uploads/origin/#{photoTakeDate}/#{newfilename}"
      newMomentFPath="#{RAILS_ROOT}/public/uploads/momentView/#{photoTakeDate}/#{newfilename}"
      newThumbFPath="#{RAILS_ROOT}/public/uploads/thumb/#{photoTakeDate}/#{newfilename}"
      
      #save the file to the origin folder
      File.copy(tempImg, newOriginFPath)
      
      #moment view photo         
      moment   = Magick::Image.read(newOriginFPath).first
      if moment.columns.to_i < 610
        File.copy(tempImg,newMomentFPath)
      else
        width=610
        height=(moment.rows*1.00/moment.columns*1.00)*width
        moment   = moment.thumbnail(width,height)
        moment.write(newMomentFPath)
      end
      
      #thumb photo(edit from newMomentFPath)
      thumb   = Magick::Image.read(newMomentFPath).first
      width=135
      height=(thumb.rows*1.00/thumb.columns*1.00)*width
      thumb = thumb.thumbnail(width,height)    
      thumb.write(newThumbFPath)
      
      #record the photo info
      photo=Photo.new           
      #for no repeating photo datetime
      if Photo.find_by_takeDatetime(photoTakeDatetime)
        photo.takeDatetime=photoTakeDatetime+1
      else
        photo.takeDatetime=photoTakeDatetime
      end
      photo.filesize=File.size(newOriginFPath)
      photo.description=""
      photo.filename = newfilename
      photo.user_id = session[:user].id
      photo.save
      
      newTakeDate = Time.gm(photo.takeDatetime.year,
                            photo.takeDatetime.month,
                            photo.takeDatetime.day)
      #judge if we need add a new take time
      if getDiaryByDatetime(photo.takeDatetime,session[:user].id).nil?
        #add to diary
        diary = Diary.new
        diary.date = newTakeDate
        diary.user_id = session[:user].id
        diary.save
      end
      File.delete(tempImg)
      GC.start
      #succeed
      #render(:text=>"<script type='text/javascript'>window.parent.UploadProgress.finish();window.parent.alertPanel.innerHTML='<div class=alertPanel>上传成功，请赶紧去发现精彩吧！<a href=/lifebook/list/#{@session[:user].id}>查看</a></div>';</script>")
    end
  end
  def edit
    @CSSs=["lifebook.css","form.css"]
    @location = "照片日记 - 记录生命"
  end
  def deleteDay
    diary = Diary.find(@params[:diary_id])
    photos = getTodayPic(diary.date,session[:user].id)
    
    #delete the file
    for photo in photos
      deleteSavedPhoto(photo)
    end
    
    Photo.destroy(photos)
    Diary.destroy(@params[:diary_id])
    redirect_to(:action=>"list",:id=>@params[:id])
  end  
  def deletePhoto
    photo = Photo.find(@params[:photo_id])
    #delete all the file
    deleteSavedPhoto(photo)
    Photo.destroy(@params[:photo_id])
    redirect_to(:action=>"day",:id=>@params[:id],:diary_id=>@params[:diary_id])
  end
  def updatePhotoDescription
    Photo.update(@params[:id],:description=>@params[:desc])
    render_text @params[:desc]
  end
  def updateDiaryTitle
    Diary.update(@params[:id],:title=>@params[:title])
    render_text @params[:title]
  end
  def updateDiaryContent
    Diary.update(@params[:id],:content=>@params[:content])
    render_text @params[:content]
  end
  def rotate
    photo   = Photo.find(params[:photo_id])
    degrees = if params[:direction] == 'left' then -90 else 90 end
    
    #3 photos saved on the server
    newOriginFPath="#{RAILS_ROOT}/public/uploads/origin/#{photo.takeDatetime.strftime('%Y-%m-%d')}/#{photo.filename}"
    newMomentFPath="#{RAILS_ROOT}/public/uploads/momentView/#{photo.takeDatetime.strftime('%Y-%m-%d')}/#{photo.filename}"
    newThumbFPath="#{RAILS_ROOT}/public/uploads/thumb/#{photo.takeDatetime.strftime('%Y-%m-%d')}/#{photo.filename}"                
    
    #main photo
    image = Magick::Image.read(newOriginFPath).first
    image = image.rotate(degrees)
    image.write(newOriginFPath)
    
    #moment view photo
    moment = Magick::Image.read(newOriginFPath).first
    width  =610
    height =(moment.rows*1.00/moment.columns*1.00)*width
    moment = moment.thumbnail(width,height)
    moment.write(newMomentFPath)
    
    #thumb photo edit from 'newMomentFPath'
    thumb  = Magick::Image.read(newMomentFPath).first
    width  =135
    height =(moment.rows*1.00/moment.columns*1.00)*width
    thumb  = thumb.thumbnail(width,height)    
    thumb.write(newThumbFPath)
    
    session[:isRotated]=true;
    redirect_to :action => 'moment',:id=>@params[:id],:diary_id=>@params[:diary_id],:page=>@params[:page]
  end
end
