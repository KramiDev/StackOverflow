class Api::V1::AnswersController < Api::V1::BaseController
  authorize_resource

  def index
    @answers = Answer.all
    respond_with @answers
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer, serializer: AnswerSerializer
  end
end