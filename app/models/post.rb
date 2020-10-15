class Post < ApplicationRecord

	belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :thanks, dependent: :destroy
	has_many :thank_users, through: :thanks, source: :user
    has_many :tag_maps, dependent: :destroy
    has_many :tags, through: :tag_maps, dependent: :destroy
    attachment :image, destroy: false
	validates :image, presence: true
	validates :content, presence: true, length: {maximum: 200}

	def thanked_by?(user)
        thanks.where(user_id: user.id).exists?
    end
end
