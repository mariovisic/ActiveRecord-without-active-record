class SessionsController < ApplicationController
  def new
    @user_login = UserLogin.new
  end

  def create
    @user_login = UserLogin.new(user_login_params)

    if @user_login.successful?
      login_user(@user_login.user, "Well done #{@user_login.display_name}, successfully logged in")
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

  def user_login_params
    params.require(:user_login).permit(:username, :password)
  end
end
