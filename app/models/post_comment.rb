class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :comment, length: { maximum: 150 }, presence: true
end
