class UserRepository
  def self.find_for_authentication(username)
    User.where('LOWER(username) = ?', username.downcase).first
  end
end
