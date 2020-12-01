class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :thanks, dependent: :destroy
  has_many :follower, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followed, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  attachment :profile_image, destroy: false

  validates :name, length: { maximum: 20, minimum: 2 }, uniqueness: true, unless: :uid?
  validates :introduction, length: { maximum: 50 }

  # is_deletedがfalseの場合は有効会員(ログイン可能)
  def active_for_authentication?
    super && (self.is_deleted === false)
  end

  # omniauthのコールバック時に呼ばれるメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを解除する
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # すでにフォロー済みであればtureを返す
  def following?(user)
    following_user.include?(user)
  end
end
