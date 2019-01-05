class Article < ApplicationRecord
  has_many :comments

  validates :title, :text, presence: true
  validates :title, length: { minimum: 5, maximum: 40 }
  validates :title, uniqueness: true, if: :title_changed?

  validate :custom_validation

  def custom_validation
    if text.index(title)
      errors.add(:text, :cannot_contain_title)
    end
  end
end
