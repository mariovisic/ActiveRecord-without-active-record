class UserDisplayName
  def initialize(user)
    @user = user
  end

  def to_s
    if @user.full_name.present?
      @user.full_name
    else
      @user.username
    end
  end
end
