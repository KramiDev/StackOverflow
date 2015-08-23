class Question < ActiveRecord::Base
  include Voteable
  include Attachable

  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :subscribes, dependent: :destroy
  belongs_to :user

  validates :title, :body, :user_id, presence: true
  validates :title, length: { minimum: 3, maximum: 150 }

  scope :yesterday, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }

  def best_answer
    self.answers.where(best: true).first
  end
end
