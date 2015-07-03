class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :body, presence: true
  default_scope { order(created_at: 'ASC') }
end
