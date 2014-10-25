class UserLogin
  include ActiveModel::Model

  attr_accessor :username, :password

  def successful?
    user.present? && password_matches?
  end

  def user
    @user ||= UserRepository.find_for_authentication(username)
  end

  def display_name
    if user.full_name.present?
      user.full_name
    else
      user.username
    end
  end

  private

  def password_matches?
    BCrypt::Password.new(user.hashed_password) == password
  end
end
