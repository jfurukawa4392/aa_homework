class ShortenedUrl < ApplicationRecord

  validates :short_url, uniqueness: true, presence: true
  validates :long_url, :submitter_id, presence: true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :tags,
    class_name: "Tagging",
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :tag_topics,
    through: :tags,
    source: :topic
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user
  )

  def self.random_code()
    random = SecureRandom::urlsafe_base64

    while ShortenedUrl.exists?(short_url: random)
      random = SecureRandom::urlsafe_base64
    end

    random
  end

  def self.generate_short_url(long_url, submitter)
    ShortenedUrl.create!(long_url: long_url,
                     short_url: self.random_code,
                     submitter_id: submitter)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.where(["updated_at >? ",5.minutes.ago]).distinct.count
  end
end
