module Voteable

  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable, dependent: :destroy

  end

  def likes_count
    self.votes.sum(:like)
  end

end