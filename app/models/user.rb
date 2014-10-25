require 'bcrypt'

class User < ActiveRecord::Base
  has_many :posts, foreign_key: :author_id

  def display_name
    if full_name.present?
      full_name
    else
      username
    end
  end
end
