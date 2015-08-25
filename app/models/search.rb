class Search
  SEARCH_RESOURCES = %w(All Question Answer Comment User)

  attr_reader :query
  attr_reader :resource

  def initialize(params)
    @query = params[:query]
    @resource = params[:resource]
  end

  def search
    return [] unless valid?
    classes = resource == 'All' ? nil : [resource]
    ThinkingSphinx.search Riddle::Query.escape("#{query}*"), classes: classes
  end

  private

  def valid?
    SEARCH_RESOURCES.include?(resource)
  end
end
