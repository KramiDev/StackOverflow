class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_vote, only: [:create, :destroy]

  include Voted


  def create
    respond_like_json(@vote)
  end

  def destroy
    @vote.find_like.destroy
    respond_to do |format|
      format.json do
         render json:
                    {
                      like: @vote,
                      likes_count: @vote.likes_count,
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