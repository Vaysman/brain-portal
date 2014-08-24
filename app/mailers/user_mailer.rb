class UserMailer < ActionMailer::Base
  default from: 'info@brain-portal.com'
 
  def registration_email(user)
    @user = user
    @url  = 'http://brain-portal.com/'
    mail(to: @user.email, subject: I18n.t('registration_mail_sub'))
  end
end
