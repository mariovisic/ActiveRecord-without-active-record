class UserRegistration
  include ActiveModel::Model

  attr_accessor :username, :password, :password_confirmation, :email, :full_name
  attr_reader :user

  validates :password_confirmation, :password, :username, :email, presence: true
  validates :password, confirmation: true
  validate :ensure_username_unique

  # FIXME: This logic is duplicated from User, please move it to a shared location
  def display_name
    if full_name.present?
      full_name
    else
      username
    end
  end

  def save
    create_user_record && send_welcome_email
  end

  private

  def create_user_record
    @user = User.create(
      username: username,
      hashed_password: BCrypt::Password.create(password),
      email: email,
      full_name: full_name
    )
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

  def ensure_username_unique
    if UserRegistration.find_for_authentication(username).present?
      errors.add(:username, 'already taken')
    end
  end
end
