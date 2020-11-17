class FollowRequest < ApplicationRecord
  belongs_to :following, class_name: 'User', foreign_key: 'following_id'
  belongs_to :followed, class_name: 'User', foreign_key: 'followed_id'
  validates_uniqueness_of :following_id, scope: :followed_id
end
