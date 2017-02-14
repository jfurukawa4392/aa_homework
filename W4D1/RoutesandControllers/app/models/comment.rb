class Comment < ActiveRecord::Base

  belongs_to :user,
    primary_key: :id,
    foreign_key: :commenter_id,
    class_name: :User

  belongs_to :comentee, polymorphic: true

end
