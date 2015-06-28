module Voted
  extend ActiveSupport::Concern

  def respond_like_json(model)
    like = load_like(model)
    find_like.destroy if find_like(model)
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

  def load_like(model)
    vote_type = params[:vote] == 'up' ? 1 : -1
    model.votes.new(like: vote_type, user: current_user)
  end

  def find_like(model)
    model.votes.where(user_id: current_user.id).first
  end




end