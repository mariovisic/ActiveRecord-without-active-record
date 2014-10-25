class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user(@user)
    else
      render :new
    end
  end

  private


  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :full_name)
  end
end
