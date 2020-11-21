class Message < ApplicationRecord
  belongs_to :member
  belongs_to :user

  validates :message, presence: true, unless: :image?

  mount_uploader :image, ImageUploader
end
