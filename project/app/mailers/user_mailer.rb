class UserMailer < ActionMailer::Base
  default from: "mica324@yahoo.com"
  
  def appt_email(user, appt)
    @user = user
    @url  = 'http://www.get2getherbooker.com/user/login'
    @appt = appt
    mail(to: user.email, subject: "#{@appt.booker_name} wants to get2gether!")
  end
end
