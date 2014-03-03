ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {  
      :address              => "smtp-sasl.cc.nctu.edu.tw",  
      :port                 => 25,  
      :domain               => 'mail.nctu.edu.tw',
      :user_name            => "easonyeh@mail.nctu.edu.tw", #Your user name
      :password             => "qazwsx1234", # Your password 
      :authentication       => 'plain',
      :enable_starttls_auto => true  
  }
   
