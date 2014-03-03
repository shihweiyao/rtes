# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery 
  before_filter :authorize, except: ['login', 'verifyCode']

  def checkPermission(hash={})
    member=Member.find(session[:member_id])   
    if hash[:type]=='member'
      unless (member.permission_config.member_p & hash[:permission]) != 0
        redirect_to controller: 'members', action: 'index', notice: '您沒有權限'      
      end
    else
      redirect_to controller: 'main', action: 'index', notice: '您沒有權限'      
    end  
  end  

  def checkMember(hash={})
    member=Member.find(session[:member_id])    
    if hash[:type]=='member'     
      if params[:id]!=session[:member_id].to_s        
          redirect_to controller: 'main', action: 'index', notice: '您沒有權限'
      end  
    else
      redirect_to controller: 'main', action: 'index', notice: '您沒有權限'      
    end    
  end   
  
protected
  def authorize
    unless Member.find_by_id(session[:member_id])
      session[:original_uri]=request.url
      flash[:notice]="請先登入,謝謝!"
      redirect_to controller: 'members', action: 'login'
    end
  end   
end
