class AnswerNotification < ApplicationMailer

  def send_mail(user, question)
    @user = user
    @question = question
    mail(to: @user.email, subject: "New answers for #{@question.title}")
  end
end
