class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:create, :best]
  before_action :find_answer, only: [:best, :destroy, :update]
  before_action :data_create, only: [:create]

  respond_to :js, only: [:update, :destroy, :best, :create]

  authorize_resource

  def create
    respond_with(@answer)
  end

  def update
    respond_with(@answer.update(answers_params))
  end

  def destroy
    respond_with(@answer.destroy)
  end

  def best
    respond_with(@answer.check_best)
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def author_email(answer)
    User.find(answer.user_id).email
  end

  def data_create
    @answer = @question.answers.create(answers_params.merge(user: current_user))
    question_author = @question.user_id
    answer_author = @answer.user_id
    @result = { question_author: question_author, answer_author: answer_author }
  end

  def answers_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end

end
