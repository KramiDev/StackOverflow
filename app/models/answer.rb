class Answer < ActiveRecord::Base
  include Modules::Helpers::SearchHelper


  belongs_to :question
  belongs_to :user

  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  has_many :votes, as: :voteable, dependent: :destroy

  default_scope { order(best: 'DESC', created_at: 'ASC') }


  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { minimum: 3, maximum: 1000 }


  def check_best
    best = self.question.best_answer
    best.update!(best: false) if best
    self.update!(best: true)
  end


end
