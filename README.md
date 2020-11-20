# Create*Create DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true, unique: true|
|age|integer||
|gender|integer||
|address|integer|null: false|
|work|string|null: false, index: true|
|image|string||
|profile|text||
|email|string|null: false, unique: true|
|password|string|null: false, unique: true|
### Association
- has_many :posts
- has_many :messages
- has_many :group_users
- has_many :groups, through: :group_users
- has_many :following_requests, foreign_key: :following_id, class_name: "FollowRequest"
- has_many :followed_requests, foreign_key: :followed_id, class_name: "FollowRequest"
- has_many :follow_okays, foreign_key: :followed_id
- has_many :recruitments

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
### Association
- has_many :messages
- has_many :group_users
- has_many :users, through: :group_users

## groups_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|group_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :group

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|message|text|null: false|
|image|string||
|user_id|references|null: false, foreign_key: true|
|group_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :group

## postsテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|image|string|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## recruitmentsテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|image|string|null: false|
|description|text|null: false|
|address|integer|null: false|
|group_id|references|null: false, foreign_key: true|
### Association
- belongs_to :group


## follow_requestsテーブル
|Column|Type|Options|
|------|----|-------|
|following_id|references|null: false|
|followed_id|references|null: false|
### Association
- belongs_to :following, class_name: 'User', foreign_key: 'following_id'
- belongs_to :followed, class_name: 'User', foreign_key: 'followed_id'

## follow_okaysテーブル
|Column|Type|Options|
|------|----|-------|
|following_id|references|null: false|
|followed_id|references|null: false|
### Association
- belongs_to :following, class_name: 'User', foreign_key: 'following_id'
- belongs_to :followed, class_name: 'User', foreign_key: 'followed_id'
