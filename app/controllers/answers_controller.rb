class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answers_params.merge(user: current_user))
    if @answer.save
      redirect_to @question, notice: 'Ваш ответ добавлен'
    else
      render 'questions/show'
    end
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    redirect_to question_path(params[:question_id]), notice: 'Ваш ответ удален'
  end

  private

  def answers_params
    params.require(:answer).permit(:body)
  end
end