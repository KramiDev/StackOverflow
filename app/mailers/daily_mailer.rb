class DailyMailer < ApplicationMailer

  def digest
    @questions = Question.where("created_at >= ?", Time.zone.now.beginning_of_day)
    User.find_each do |user|
      mail(to: user.email, subject: 'Daily Digest')
    end
  end
end
