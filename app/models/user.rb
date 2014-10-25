require 'bcrypt'

class User < ActiveRecord::Base
  has_many :posts, foreign_key: :author_id

  attr_accessor :password

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
end
