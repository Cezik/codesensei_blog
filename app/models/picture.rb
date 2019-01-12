class Picture < ApplicationRecord
  belongs_to :article

  mount_uploader :image, ImageUploader

  validates :image, presence: true
end
