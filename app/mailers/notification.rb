class Notification < ApplicationMailer

  def send_mail(answer)
    @question = answer.question
    @user = @question.user
    mail(to: @user.email, subject: 'Your question has new answers')
  end
end
