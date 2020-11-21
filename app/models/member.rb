class Member < ApplicationRecord
  has_many :member_users
  has_many :users, through: :member_users
  has_many :messages
  validates :name, presence: true, uniqueness: true
end
