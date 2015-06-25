class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:question_id]
      @question = Question.find(params[:question_id])
      @like = @question.votes.new(like: params[:vote], user: current_user)
      respond_to do |format|
        if @like.save
          format.json { render json: { 
            like: @like,
            likes_count: @question.likes_count
          } }
        else
          format.json { render json: @like.errors.full_messages, status: :unprocessable_entity }
        end
      end
    elsif params[:answer_id]
      @answer = Answer.find(params[:answer_id])
      @like = @answer.votes.new(like: params[:vote], user: current_user)
      respond_to do |format|
        if @like.save
          format.json { render json: {
            like: @like,
            likes_count: @answer.likes_count
          } }
        else
          format.json { render json: { like: @like, errors: @like.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end
  end

end
