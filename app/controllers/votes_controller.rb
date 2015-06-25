class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:question_id]
      @question = Question.find(params[:question_id])
      load_like(@question)
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
      load_like(@answer)
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

  private

  def load_like(model)
    @like = model.votes.new(like: params[:vote], user: current_user)
  end

end
