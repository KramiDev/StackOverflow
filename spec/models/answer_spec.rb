require 'rails_helper'

RSpec.describe Answer, type: :model do

  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least(3).is_at_most(1000) }

  it { should belong_to(:question) }
  it { should belong_to(:user) }

  it { should validate_presence_of :user_id }
  it { should validate_presence_of :question_id }

  it { should have_many(:attachments).dependent(:destroy) }
  it { should accept_nested_attributes_for :attachments }

  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question, best: false) }
  let(:answer1) { create(:answer, question: question, best: false) }

  describe '#best_answer' do

    it 'Question does\'t have best answer' do

      answer.best_answer

      expect(answer.best).to be true

    end

    before { answer1.update!(best: true) }

    it 'Question have 1 best answer' do

      answer.best_answer
      answer1.reload
      expect(answer.best).to be true
      expect(answer1.best).to be false

    end

  end


end
