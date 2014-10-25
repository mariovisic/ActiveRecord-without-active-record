class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome(user)
    @user = user

    mail to: user.email, subject: 'Welcome to the site'
  end

  def new_post(user, post)
    @user = user
    @post = post

    mail to: user.email, subject: "New post: #{post.title}"
  end
end
