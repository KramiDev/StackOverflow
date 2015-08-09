class Answer < ActiveRecord::Base
  include Voteable
  include Attachable

  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { minimum: 3, maximum: 1000 }

  def check_best
    best = self.question.best_answer
    best.update!(best: false) if best
    self.update!(best: true)
  end
end
