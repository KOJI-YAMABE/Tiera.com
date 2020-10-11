class Post < ApplicationRecord

	belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :thanks, dependent: :destroy
	has_many :thank_users, through: :thanks, source: :user
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :image, presence: true
	validates :content, presence: true, length: {maximum: 200}

	def thanked_by?(user)
        thanks.where(user_id: user.id).exists?
    end

end
