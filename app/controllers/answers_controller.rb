class AnswersController < ApplicationController
  before_action :authenticate_user!


  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answers_params.merge(user: current_user))
    if @answer.save
      flash[:notice] = 'Ответ успешно добавлен'
    else
      flash[:alert] = 'Ответ не сохранен'
    end
  end

  def update
    @answer = Answer.find(params[:id])
    if current_user.id && @answer.user_id
      if @answer.update(answers_params)
        flash[:notice] = 'Ответ обновлен'
      else
        flash[:alert] = 'Не удалось обновить ответ'
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.user_id == current_user.id
      @answer.destroy
      flash[:notice] = 'Ваш ответ удален'
    else
      flash[:alert] = 'Ответ не удален'
    end
  end

  def best
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    trueAnswer = @question.answers.where(best: true).first
    if trueAnswer
      trueAnswer.update(best: false)
    end
    if @question.user_id == current_user.id
      @answer.update!(best: true)
      @user = User.find(@answer.user_id)
      flash[:notice] = 'Ответ ' + @user.email + ' был выбран лучшим'
    end

  end

  private

  def answers_params
    params.require(:answer).permit(:body)
  end
end
