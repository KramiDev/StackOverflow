module Modules
  module Vote

    def respond_like_json(model)
      like = load_like(model)
      respond_to do |format|
        if like.save
          format.json { render json: {
                                   like: like,
                                   likes_count: model.likes_count
                               } }
        else
          format.json { render json: like.errors.full_messages, status: :unprocessable_entity }
        end
      end
    end

    private

    def load_like(model)
      model.votes.new(like: params[:vote], user: current_user)
    end

  end
end