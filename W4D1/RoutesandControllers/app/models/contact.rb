class Contact < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :user_id, presence: true, uniqueness: true

  belongs_to :user

  has_many :contact_shares

  has_many :shared_users,
    through: :contact_shares,
    source: :recipient_user
end
