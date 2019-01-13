class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  validates :commenter, :body, presence: true
end
