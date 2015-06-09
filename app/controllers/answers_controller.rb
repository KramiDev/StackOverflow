class AnswersController < ApplicationController
  before_action :authenticate_user!


  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answers_params.merge(user: current_user))
  end

  def destroy
    answer = Answer.find(params[:id])
    if answer.user_id == current_user.id
      answer.destroy
      redirect_to question_path(answer.question), notice: 'Ваш ответ удален'
    else
      redirect_to question_path(answer.question)
    end
  end

  private

  def answers_params
    params.require(:answer).permit(:body)
  end
end
