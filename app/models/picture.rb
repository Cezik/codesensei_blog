class Picture < ApplicationRecord
  belongs_to :article

  mount_uploader :image, ImageUploader

  validates :image, :title, :description, presence: true
end
