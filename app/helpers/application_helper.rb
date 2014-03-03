module ApplicationHelper
  def host
    "http://192.168.1.125:12345"
  end 

  def checkPermission(hash={})
    member=Member.find( hash[:member_id] || session[:member_id])   
    if hash[:type]=='member'
      unless (member.permission_config.member_p & hash[:permission]) != 0
        false    
      else
        true
      end
    else
      false     
    end 
  end   
end
