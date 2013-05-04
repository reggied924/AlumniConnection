class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email.subject
  #
  def welcome_email(user)
    @user = user

    mail to: user.email, subject: 'Welcome to Alumni Connection!', from: 'WebMaster@AlumniConnection.com'
  end
  
  #Added an emailer for a new job posting - DStone - 3-5-2013  
  def jobpost_email(user)
    @user = user
    
    mail to: user.email, subject: 'Thank you for posting a new job', from: 'WebMaster@AlumniConnection.com'
  end
end