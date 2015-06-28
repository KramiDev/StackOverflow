module Voted
  extend ActiveSupport::Concern

  def respond_like_json(model)
    like = load_like(model)
    check_like(model)
    respond_to do |format|
      if like.save
        format.json do
          render json:
                     {  like: like,
                        likes_count: model.likes_count
                     }
        end
      else
        format.json { render json: like, status: :unprocessable_entity }
      end
    end
  end

  private

  def check_like(model)
    like = model.votes.where(user_id: current_user.id).first
    like.destroy if like
  end

  def load_like(model)
    vote_type = params[:vote] == 'up' ? 1 : -1
    model.votes.new(like: vote_type, user: current_user)
  end


end