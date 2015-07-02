class Question < ActiveRecord::Base
  include Voteable
  include Attachable

  has_many :answers, dependent: :destroy
  belongs_to :user

  default_scope { order(created_at: 'DESC') }

  validates :title, :body, :user_id, presence: true
  validates :title, length: { minimum: 3, maximum: 150 }

  def best_answer
    self.answers.where(best: true).first
  end
end
