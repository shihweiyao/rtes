# encoding: UTF-8
class AssetList < ActiveRecord::Base
  attr_accessible :location, :name, :owner, :time, :member_id
  belongs_to :member
  
    validates :name , :presence =>{:message => "姓名 不能是空白"} 
    validates :location, :presence =>{:message => "地點 不能是空白"}
end
