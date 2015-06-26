class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_vote, only: [:create]

  include Modules::Controllers::Vote


  def create
    respond_like_json(@vote)
  end

  private

  def load_vote
    @vote =  params[:question_id] ? Question.find(params[:question_id]) : Answer.find(params[:answer_id])
  end

end