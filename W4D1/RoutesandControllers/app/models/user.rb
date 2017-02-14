
class User < ActiveRecord::Base
  validates :username, presence: true

  has_many :contacts, dependent: :destroy

  has_many :contacts_shared_with_this_user, dependent: :destroy,
  foreign_key: :user_id,
  class_name: :ContactShare


  has_many :shared_contacts,
    through: :contacts_shared_with_this_user,
    source: :contact

  has_many :comments_on, as: :comentee

  has_many :comments,
    foreign_key: :commenter_id,
    class_name: :Comment
end
