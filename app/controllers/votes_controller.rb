class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_vote, only: [:create]

  include Modules::Controllers::Vote


  def create
    respond_like_json(@vote)
  end

  def cancel
    @question = Question.find(params[:question_id])
    @question.votes.where(user_id: current_user.id).first.destroy
    respond_to do |format|
      format.json { render json: {status: :success} }
    end
  end

  private

  def load_vote
    @vote =  params[:question_id] ? Question.find(params[:question_id]) : Answer.find(params[:answer_id])
  end

end