class Subscribe < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :user_id, presence: true
  validates :question_id, presence: true, uniqueness: { scope: :user_id }
end
