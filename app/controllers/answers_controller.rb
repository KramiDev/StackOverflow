class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:create, :best]
  before_action :find_answer, only: [:best, :destroy, :update]


  def create
    @answer = @question.answers.new(answers_params.merge(user: current_user))
    @answer.save ? flash[:notice] = 'Ответ успешно добавлен' : flash[:alert] = 'Ответ не сохранен'
  end

  def update
    if current_user.id == @answer.user_id
      @answer.update(answers_params) ? flash[:notice] = 'Ответ обновлен' : flash[:alert] = 'Не удалось обновить ответ'
    end
  end

  def destroy
    if current_user.id == @answer.user_id
      @answer.destroy ? flash[:notice] = 'Ваш ответ удален' : flash[:alert] = 'Ответ не удален'
    end
  end

  def best
    if current_user.id == @question.user_id
      @answer.best_answer
      flash[:notice] = 'Ответ ' + author_email(@answer) + ' был выбран лучшим'
    end
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

  def answers_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
