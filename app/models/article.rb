class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy

  before_validation :strip_html_tags, if: :text
  before_save :bold_markdown, if: :text

  validates :title, :text, presence: true
  validates :title, length: { minimum: 5, maximum: 40 }
  # validates :author, length: { minumum: 3, maximum: 60 }
  validates :title, uniqueness: true, if: :title_changed?
  validates :terms_of_service, acceptance: true

  validate :custom_validation, if: :text

  def custom_validation
    errors.add(:text, :cannot_contain_title) if text.index(title)
  end

  private

  def strip_html_tags
    text.gsub!(/<[^>]*>/, '')
  end

  def bold_markdown
    text.gsub!(/\*(.+?)\*/, '<b>\1</b>')
  end
end
