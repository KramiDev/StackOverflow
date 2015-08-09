class Api::V1::QuestionsController < Api::V1::BaseController
  authorize_resource

  def index
    @questions = Question.all
    respond_with @questions, each_serializer: QuestionSerializer
  end

  def show
    @question = Question.find(params[:id])
    respond_with @question, serializer: QuestionSerializer
  end

  def create
    @question = Question.create(questions_params.merge(user: current_resource_owner))
    respond_with @question
  end

  private

  def questions_params
    params.require(:question).permit(:title, :body)
  end
end
