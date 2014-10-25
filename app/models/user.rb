require 'bcrypt'

class User < ActiveRecord::Base
  attr_reader   :password
  attr_accessor :password_confirmation

  validates :password_confirmation, presence: true, if: :password
  validates :password, presence: true, confirmation: true, on: :create
  validates :username, :email, presence: true
  validates :username, uniqueness: true

  has_many :posts, foreign_key: :author_id

  after_create :send_welcome_email

  def self.find_for_authentication(username)
    where('LOWER(username) = ?', username.downcase).first
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  def password_matches?(password)
    BCrypt::Password.new(hashed_password) == password
  end

  def display_name
    if full_name.present?
      full_name
    else
      username
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self)
  end
end
