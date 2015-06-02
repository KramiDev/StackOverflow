require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { FactoryGirl.create(:question) }
  let(:answer) { create(:answer) }

  describe 'POST #create' do

    context 'with valid attributes' do

      it 'saves answer in database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(Answer, :count).by(1)
        expect(Answer.last.question_id).to eq question.id
      end

      it 'redirect to question with id' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(question)
      end

    end

    context 'without valid attributes' do

      it 'does not save answer in database' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end


    end

  end



end
