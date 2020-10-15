class Tag < ApplicationRecord
	has_many :tag_maps, dependent: :destroy, foreign_key: "tag_id"
	has_many :posts, through: :tag_maps
	validates :tag_name, length: {maximum: 20}

	def self.search(search)
    	return Tag.all() unless search
    	Tag.where('tag_name LIKE(?)', "%#{search}%")
  	end
end
