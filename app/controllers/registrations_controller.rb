class RegistrationsController < ApplicationController
  def new
    @user_registration = UserRegistration.new
  end

  def create
    @user_registration = UserRegistration.new(user_registration_params)

    if @user_registration.save
      login_user(@user_registration.user, "Well done #{UserDisplayName.new(@user_registration.user)}, registration complete")
    else
      render :new
    end
  end

  private

  def user_registration_params
    params.require(:user_registration).permit(:email, :username, :password, :password_confirmation, :full_name)
  end
end
