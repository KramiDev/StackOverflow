class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :build_answer, only: [:show]

  respond_to :js, only: [:create, :update]

  authorize_resource

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with(@question)
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
  end

  def create
    respond_with(@question = Question.create(questions_params.merge(user: current_user)))
  end

  def update
    respond_with(@question.update(questions_params))
  end

  def destroy
    respond_with(@question.destroy)
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def build_answer
    @answer = @question.answers.build
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
