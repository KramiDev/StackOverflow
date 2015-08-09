class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_question, only: [:create]
  authorize_resource

  def index
    @answers = Answer.all
    respond_with @answers
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer, serializer: AnswerSerializer
  end

  def create
    @answer = @question.answers.create(answers_params.merge(user: current_resource_owner))
    respond_with :api, :v1, @answer
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answers_params
    params.require(:answer).permit(:body)
  end
end