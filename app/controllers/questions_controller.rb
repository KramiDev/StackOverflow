class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
    @comment = @question.comments.build
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = Question.new(questions_params.merge(user: current_user))
    @question.save
    respond_to do |format|
      format.js {}
    end
  end

  def update
    if @question.update(questions_params)
      flash[:notice] = 'Вопрос успешно обновлен'
    else
      flash[:alert] = 'Обновить не удалось'
    end
  end

  def destroy
    if @question.user_id == current_user.id
      @question.destroy
      redirect_to questions_path, notice: 'Ваш вопрос удален'
    else
      redirect_to @question
    end
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
