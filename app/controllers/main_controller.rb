# encoding: UTF-8
class MainController < ApplicationController

  def index
  end  
     
  def self.weeklyMail
    @members=Member.find(1)   
            SystemMailer.weeklyReportMailSending(@members).deliver   
       
  end
end
