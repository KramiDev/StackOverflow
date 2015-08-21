class SubscribesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  authorize_resource

  respond_to :js

  def create
    @subscribe = Subscribe.create(question: @question, user: current_user)
  end

  def destroy
    @subscribe = Subscribe.find(params[:id])
    @subscribe.destroy
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end
