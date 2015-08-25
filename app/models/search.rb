class Search
  SEARCH_RESOURCES = %w(All Question Answer Comment User)

  attr_reader :query
  attr_reader :resource

  def initialize(params)
    @query = params[:query]
    @resource = params[:resource]
  end

  def search
    if resource == 'All'
      ThinkingSphinx.search Riddle::Query.escape("#{query}*")
    else
      resource.classify.constantize.search Riddle::Query.escape("#{query}*")
    end
  end
end