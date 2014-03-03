# encoding: UTF-8
class PermissionConfig < ActiveRecord::Base
  attr_accessible :member_id, :member_p  
  belongs_to :member  
end