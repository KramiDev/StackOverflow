module Modules::Controllers::Vote

    def respond_like_json(model)
      like = load_like(model)
      respond_to do |format|
        if like.save
          format.json { render json: {
                                   like: like,
                                   likes_count: model.likes_count
                               } }
        else
          format.json { render json: like, status: :unprocessable_entity }
        end
      end
    end

    private

    def load_like(model)
      vote_type = params[:vote] == 'up' ? 1 : -1
      model.votes.new(like: vote_type, user: current_user)
    end

  end