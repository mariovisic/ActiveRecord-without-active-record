class Post < ActiveRecord::Base
  belongs_to :author, class_name: :User

  validates :author, :title, :body, presence: true

  after_create :notify_all_users

  private

  def notify_all_users
    User.find_each do |user|
      UserMailer.new_post(user, self).deliver
    end
  end
end
