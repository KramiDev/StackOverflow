class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_vote, only: [:create, :destroy]

  authorize_resource

  def create
    like = Vote.new_like(@parent, current_user, params)
    check_like = Vote.first_like(@parent, current_user)
    check_like.destroy if check_like
    respond_to do |format|
      if like.save
        format.json do
          render json:
          {
            like: like,
            likes_count: @parent.likes_count
          }
        end
      else
        format.json { render json: like, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vote.destroy
    respond_to do |format|
      format.json do
        render json:
        {
          like: @parent,
          likes_count: @parent.likes_count,
          status: :success
        }
      end
    end
  end

  private

  def load_vote
    @parent =  params[:question_id] ? Question.find(params[:question_id]) : Answer.find(params[:answer_id])
    @vote = @parent.votes.where(user: current_user).first
  end
end
