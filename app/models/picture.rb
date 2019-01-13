class Picture < ApplicationRecord
  belongs_to :article
  has_many :comments, dependent: :destroy, as: :commentable 

  mount_uploader :image, ImageUploader

  validates :image, :title, :description, presence: true
end
