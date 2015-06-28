class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_vote, only: [:create, :destroy]

  include Voted


  def create
    respond_like_json(@vote)
  end

  def destroy
    @vote.votes.where(user_id: current_user.id).first.destroy
    likes_count = @vote.likes_count
    respond_to do |format|
      format.json do
         render json:
                    { likes_count: likes_count,
                      status: :success
                    }
      end
    end
  end

  private

  def load_vote
    @vote =  params[:question_id] ? Question.find(params[:question_id]) : Answer.find(params[:answer_id])
  end

end