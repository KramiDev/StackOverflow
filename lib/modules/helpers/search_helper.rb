module Modules::Helpers::SearchHelper


  def likes_count
    self.votes.sum(:like)
  end

end