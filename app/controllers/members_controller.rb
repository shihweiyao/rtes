# encoding: UTF-8
require 'securerandom'
class MembersController < ApplicationController
  
  before_filter(only: [:edit, :update, :show]) { |c| c.checkMember(type: 'member', permission: GLOBAL_VAR['update_permission'] )}    
  before_filter(only: [:createMember]) { |c| c.checkPermission(type: 'member', permission: GLOBAL_VAR['create_permission'] )}
  before_filter(only: [:permissionConfig, :pwReset]) { |c| c.checkPermission(type: 'member', permission: GLOBAL_VAR['update_permission'] )} 
  before_filter(only: [:destory]) { |c| c.checkPermission(type: 'member', permission: GLOBAL_VAR['delete_permission'] )}
  
  def index   
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])  
  end

  def update
    @member = Member.find(params[:id])
    @member.update_attributes!(params[:member])
		if !@member.verified
	     @member.verified=true
		end
		@member.save!
		redirect_to @member, notice: '成功編輯!'
    rescue ActiveRecord::RecordInvalid
      @member.valid? 
      render action: 'edit'
  end

  def destroy
    @member = Member.find(params[:id]) 
    @member.permission_config.destroy
    @member.destroy
    redirect_to members_url
  end

  def permissionConfig  
    if request.post?               
      @permission_config = PermissionConfig.find(params[:permission_config][:id])     
      @permission_config.member_p =  params[:mem_read].to_i | params[:mem_update].to_i | params[:mem_create].to_i | params[:mem_delete].to_i
      @permission_config.save!
      redirect_to members_url         
    else
      @permission_config = PermissionConfig.find_by_member_id(params[:id])
    end   
  end 

  def createMember 
    if request.post?
      @member=Member.new(email: params[:email], verification_code: SecureRandom.hex(5),
                         name:  params[:name])                              
      @member.save! 
      permission_config=PermissionConfig.new        
      permission_config.member=@member
      permission_config.save! 
      SystemMailer.sendVerification(@member).deliver 
      redirect_to controller: 'main', action: 'index', notice: '成功送出帳號邀請函'
    end
    rescue ActiveRecord::RecordInvalid
      @member.valid?     
      render action: 'createMember'  
  end

  def verifyCode
    @member=Member.find(params[:id])
    if @member.verification_code==params[:verification_code]&&!@member.verified
      session[:member_id]=@member.id
      redirect_to controller: 'members', action: 'edit', id: params[:id]   
    else 
      redirect_to controller: 'main', action: 'index' 
    end
  end

  def pwReset
    member=Member.find(params[:id])
    new_pw = SecureRandom.hex(5)
    member.pw= new_pw
    member.pw_confirmation= new_pw
    member.save!
    SystemMailer.sendNewPw(member, new_pw).deliver 
    redirect_to members_url 
  end

  def login
   session[:member_id]=nil
   if request.post?
      member=Member.authenticate(params[:username], params[:password])
       if member
         session[:member_id]=member.id
         uri=session[:original_uri]
         session[:original_uri]=nil
         redirect_to ( uri|| {controller: 'main', action: 'index'} )
       else
         flash.now[:notice]="錯誤的帳號或密碼"
       end
    end
  end

  def logout
    session[:member_id]=nil
    flash[:notice]="已經登出"
    redirect_to controller: 'main', action: 'index'
  end 
       
end
