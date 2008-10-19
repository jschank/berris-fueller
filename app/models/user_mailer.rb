class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://#{smtp_settings[:domain]}/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{smtp_settings[:domain]}/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "jschank@mac.com"
      @subject     = "berris-fueller new user signup - "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
