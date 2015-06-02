class AnswersController < ApplicationController

  def create
    question = Question.find(params[:question_id])
    question.answers.build(answers_params)
    question.save
    redirect_to question
  end

  private

  def answers_params
    params.permit(:body)
  end
end
