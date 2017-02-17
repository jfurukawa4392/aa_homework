class Toy < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :name, uniqueness: { scope: [:toyable_id, :toyable_type], message: "this animal already has this toy" }

  belongs_to :toyable, polymorphic: true
end
