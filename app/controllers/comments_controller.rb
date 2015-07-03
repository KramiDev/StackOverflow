class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_association, only: [:create]

  def create
    @comment = @parent.comments.create(comments_params.merge(user: current_user))
    respond_to do |format|
      format.js {}
    end
  end

  private
  def check_association
    @parent = params[:answer_id] ? Answer.find(params[:answer_id]) : Question.find(params[:question_id])
  end

  def comments_params
    params.require(:comment).permit(:body)
  end
end
