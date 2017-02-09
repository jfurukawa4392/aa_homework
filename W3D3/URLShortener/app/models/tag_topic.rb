class TagTopic < ApplicationRecord
  validates :topic, uniqueness: true, presence: true

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :topic_id,
    primary_key: :id
  )

  has_many(
    :links,
    through: :taggings,
    source: :topic_url
  )

  def popular_links
    self.links.joins(:visits).group(:short_url).order('count(user_id) DESC').limit(5)
  end
end
