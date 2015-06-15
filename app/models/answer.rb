class Answer < ActiveRecord::Base

  belongs_to :question
  belongs_to :user

  default_scope { order(best: 'DESC', created_at: 'DESC') }


  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { minimum: 3, maximum: 1000 }


  def best_answer
    best = self.question.load_best_answer
    best.update!(best: false) if best
    self.update!(best: true)
  end

end
