class Visit < ApplicationRecord
  validates :user_id, :url_id, presence: true

  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :short_url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id
  )

  def self.record_visit!(user, shortenedurl)
    Visit.create(user_id: user.id, url_id: shortenedurl.id)
  end

end
