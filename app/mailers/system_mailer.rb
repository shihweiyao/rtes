# encoding: utf-8
class SystemMailer < ActionMailer::Base
  default from: "系統 <inforsec@nctu.edu.tw>"
  helper ApplicationHelper
 
  
  def sendVerification(member)
      @id=member.id
      @verification_code=member.verification_code
      mail( to: member.email , subject:"系統 會員系統 邀請函")
  end
  def sendNewPw(member, new_pw)
    @new_pw=new_pw
    mail( to: member.email , subject:"系統 會員系統 密碼重設")    
  end
  def weeklyReportMailSending(member)
      @member=member
      mail( to: member.email , subject:"Testing")
  end
end



