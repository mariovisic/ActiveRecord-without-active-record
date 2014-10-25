class UserLogin
  include ActiveModel::Model

  attr_accessor :username, :password

  def successful?
    user.present? && password_matches?
  end

  def user
    @user ||= UserRepository.find_for_authentication(username)
  end

  private

  def password_matches?
    BCrypt::Password.new(user.hashed_password) == password
  end
end
