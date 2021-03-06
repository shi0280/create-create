class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# Validation
  validates :name, presence: true, uniqueness: true
  validates :work, :adress, presence: true

# Relation
  has_many :posts
  has_many :following_requests, dependent: :destroy, foreign_key: :following_id, class_name: "FollowRequest"
  has_many :followed_requests, dependent: :destroy, foreign_key: :followed_id, class_name: "FollowRequest"
  has_many :following_okays, dependent: :destroy, foreign_key: :following_id, class_name: "FollowOkay"
  has_many :followed_okays, dependent: :destroy, foreign_key: :followed_id, class_name: "FollowOkay"
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :member_users
  has_many :members, through: :member_users
  has_many :messages

  mount_uploader :image, ImageUploader

# Enum
  enum gender: {男性:1, 女性:2}
  enum adress: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }

# Method
## 検索
  def self.search(search)
    if search
      User.where('work LIKE(?)', "%#{search}%")
    else
      User.all
    end
  end
## フォローリクエスト判定
  def already_requested?(followed)
    self.following_requests.exists?(followed_id: followed.id)
  end
## 仲間登録済み判定
  def already_following?(following)
    self.followed_okays.exists?(following_id: following.id)
  end

  def already_followed?(followed)
    self.following_okays.exists?(followed_id: followed.id)
  end

end

