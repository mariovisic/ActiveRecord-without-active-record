class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if authentication_successful?
      login_user(@user)
    else
      flash[:error] = 'Your username or password is incorrect'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def authentication_successful?
    authenticated_user && authenticated_user.password_matches?(password)
  end

  def authenticated_user
    @authenticated_user ||= User.find_for_authentication(username)
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def username
    user_params[:username]
  end

  def password
    user_params[:password]
  end
end
