require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:title).is_at_least(3).is_at_most(150) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should validate_presence_of :user_id }
  it { should accept_nested_attributes_for :attachments }

  let!(:users) { create_list(:user, 4) }
  let!(:question) { create(:question) }

  describe '#likes_count' do
    before { question.votes.create!(like: 1, user: users[0]) }
    before { question.votes.create!(like: 1, user: users[1]) }
    before { question.votes.create!(like: -1, user: users[2]) }
    before { question.votes.create!(like: 1, user: users[3]) }

    it 'Get all likes of question' do
      expect(question.likes_count).to eq 2
    end
  end
end
