class AnswerNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(answer)
    question = answer.question
    question.subscribes.find_each do |subscribe|
      AnswerNotification.send_mail(subscribe.user, question).deliver_later
    end
  end
end
