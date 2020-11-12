class Relationship < ApplicationRecord
  # Relation
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
  # Validation
  validates :follower_id, presence: true
  validates :following_id, presence: true
  validates_uniqueness_of :follower_id, scope: :following_id
end
