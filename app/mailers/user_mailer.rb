class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome(user)
    @user = user

    mail to: user.email, subject: 'Welcome to the site'
  end
end
