class Answer < ActiveRecord::Base
  include Voteable
  include Attachable

  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { minimum: 3, maximum: 1000 }

  after_create :answer_notification

  def check_best
    best = self.question.best_answer
    best.update!(best: false) if best
    self.update!(best: true)
  end

  private

  def answer_notification
    Notification.send_mail(self).deliver_later
    AnswerNotificationJob.perform_later(self)
  end
end
