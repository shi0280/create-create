class Group < ApplicationRecord
# Relation
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :recruitments, dependent: :destroy
   	
  accepts_nested_attributes_for :recruitments, allow_destroy: true
# Validation
  validates :name, presence: true, uniqueness: true
end
