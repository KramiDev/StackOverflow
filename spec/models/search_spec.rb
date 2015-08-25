require 'rails_helper'

RSpec.describe Search, type: :model do

  describe '#search' do
    it 'If params with errors return empty array' do
      search = Search.new(resource: '123', query: '')
      expect(search.search).to be_empty
    end

    it 'if params resource All return all result' do
      search = Search.new(resource: 'All', query: 'asd asd')
      expect(ThinkingSphinx).to receive(:search).with(Riddle::Query.escape("#{search.query}*"), classes: nil)
      search.search
    end

    it 'if params resource All return all result' do
      %w(Question Answer Comment User).each do |resource|
        search = Search.new(resource: resource, query: 'asd asd')
        expect(ThinkingSphinx).to receive(:search).with(Riddle::Query.escape("#{search.query}*"), classes: [resource])
        search.search
      end
    end
  end
end