class Answer < ActiveRecord::Base

  belongs_to :question
  belongs_to :user

  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  has_many :votes, as: :voteable, dependent: :destroy

  default_scope { order(best: 'DESC', created_at: 'ASC') }


  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { minimum: 3, maximum: 1000 }


  def best_answer
    best = self.question.best_answer
    best.update!(best: false) if best
    self.update!(best: true)
  end

  def likes_count
    self.votes.sum(:like)
  end

end
