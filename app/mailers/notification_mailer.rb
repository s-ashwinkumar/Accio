class NotificationMailer < ActionMailer::Base

  default :from => "accio.boss@gmail.com"

  def notify(recepient,body)
    mail(:to => recepient, :subject => "Accio Notification !", :body => body).deliver
  end
end