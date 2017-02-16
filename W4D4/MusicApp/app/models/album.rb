class Album < ActiveRecord::Base
  validates :band_id, :title, presence: true
  validates :band_id, uniqueness: { scope: :title }

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
