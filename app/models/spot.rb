class Spot < ApplicationRecord
  belongs_to :post
  geocoded_by :address
  after_validation :geocode
  validates :address, presence: true
  validate :check_latitude
  validate :check_longitude

  def check_latitude
    if latitude.nil?
      errors.add(:latitude, "マップから別の場所を選択してください。（または英語で記入してください）")
    end
  end

  def check_longitude
    if longitude.nil?
      errors.add(:longitude, "マップから別の場所を選択してください。（または英語で記入してください）")
    end
  end
end
