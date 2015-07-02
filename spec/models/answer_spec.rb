require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_length_of(:body).is_at_least(3).is_at_most(1000) }
  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :question_id }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should accept_nested_attributes_for :attachments }

  let!(:users){ create_list(:user, 4) }
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question, best: false) }
  let!(:answer1) { create(:answer, question: question, best: false) }

  describe '#check_best' do
    it 'Question does\'t have best answer' do
      answer.check_best
      expect(answer.best).to be true
    end

    before { answer1.update!(best: true) }

    it 'Question have 1 best answer' do
      answer.check_best
      answer1.reload
      expect(answer.best).to be true
      expect(answer1.best).to be false
    end
  end

 describe '#likes_count' do
    before { answer.votes.create!(like: 1, user: users[0]) }
    before { answer.votes.create!(like: 1, user: users[1]) }
    before { answer.votes.create!(like: 1, user: users[2]) }
    before { answer.votes.create!(like: -1, user: users[3]) }

    it 'Get all likes of question' do
      expect(answer.likes_count).to eq 2
    end
  end
end
