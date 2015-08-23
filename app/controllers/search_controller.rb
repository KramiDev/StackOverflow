class SearchController < ApplicationController
  skip_authorization_check
  def search
    # render json: params
    @search = Search.new(
      query: params[:query],
      resource: params[:resource]
    )
    @result = @search.search
  end
end
