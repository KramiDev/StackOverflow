class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = current_user.questions.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(questions_params)
    if @question.save
      redirect_to @question, notice: 'Ваш вопрос успешно создан'
    else
      render :new
    end
  end

  def update
    if @question.update(questions_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Ваш вопрос удален'
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body)
  end
end
