class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user



  validates :title, :body, :user_id, presence: true
  validates :title, length: { minimum: 3, maximum: 150 }


  def load_best_answer
    self.answers.where(best: true).first
  end
end
