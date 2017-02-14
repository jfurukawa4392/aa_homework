class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :contact_id }

  belongs_to :recipient_user

  belongs_to :contact
end
