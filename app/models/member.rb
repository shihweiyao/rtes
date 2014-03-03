# encoding: UTF-8
require 'digest/sha1'
class Member < ActiveRecord::Base
  attr_accessible :email, :name, :phone, :pw, :username, :pw_confirmation, :verification_code, :verified
  attr_accessor :pw_confirmation 
  has_one  :permission_config
  has_many :asset_lists
    
  validates :name, :presence =>{:message => "姓名 不能是空白"}
  validates :username, :uniqueness =>{ :message =>"帳號 已經使用過" }, :presence => { :message =>"帳號 不能是空白" }, :on=>:update
  validates :email, :presence =>{:message => "email 不能是空白"}
  validates :pw, :presence =>{:message => "密碼 不能是空白"}, :confirmation =>{:message => "密碼 輸入不一致"}, :on=>:update
  validates :pw_confirmation, :presence =>{:message => "密碼確認 不能是空白"}, :on=>:update
  
#=========================================================================for pw
  def pw
    @pw
  end
  def pw=(pwd)
    @pw=pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_pw=Member.encrypted_password(self.pw,self.salt)
  end
  def self.authenticate(username,password)
    member=self.find_by_username(username)
    if member
      expected_password=encrypted_password(password,member.salt)
      if member.hashed_pw!=expected_password
        member=nil
      end
    end
    member
  end
  
private
  def create_new_salt
    self.salt = self.object_id.to_s+rand.to_s
  end
  def self.encrypted_password(password,salt)
    string_to_hash=password+"infor2012"+salt
    Digest::SHA1.hexdigest(string_to_hash)
  end  
end
