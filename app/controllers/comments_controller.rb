class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_params, only: [:create]

  def create
    @answer ? create_comment(@answer) : create_comment(@question)
  end

  private
  def load_params
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id]) if params[:answer_id]
  end

  def create_comment(model)
    @comment = model.comments.create(comments_params.merge(user: current_user))
  end

  def comments_params
    params.require(:comment).permit(:body)
  end
end
