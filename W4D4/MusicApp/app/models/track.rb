class Track < ActiveRecord::Base
  validates :album_id, :name, presence: true

  belongs_to :album
end
