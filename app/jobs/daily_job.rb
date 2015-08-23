class DailyJob < ActiveJob::Base
  queue_as :default

  def perform
    questions = Question.yesterday
    User.find_each do |user|
      DailyMailer.digest(user, questions).deliver_later
    end
  end
end
