class Member < ApplicationRecord
# Association
  has_many :member_users
  has_many :users, through: :member_users
  has_many :messages

# Validation
  validates :name, presence: true, uniqueness: true

# Method
  def show_last_message
    if (last_message = messages.last).present?
      if last_message.message?
        last_message.message
      else
        '画像が投稿されています'
      end
    else
      'まだメッセージはありません。'
    end
  end
end
