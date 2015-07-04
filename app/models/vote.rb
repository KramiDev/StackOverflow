class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:voteable_id, :voteable_type] }

  def self.new_like(model, user, params)
    vote_type = params[:vote] == 'up' ? 1 : -1
    model.votes.new(like: vote_type, user: user)
  end

  def self.first_like(model, user)
    model.votes.where(user: user).first
  end
end
