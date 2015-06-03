class AnswersController < ApplicationController


  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answers_params)
    if @answer.save
      redirect_to @question
    else
      @question.reload
      render 'questions/show'
    end
  end

  private

  def answers_params
    params.require(:answer).permit(:body)
  end
end
