require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { FactoryGirl.create(:question) }
  let(:answer) { create(:answer) }

  describe 'POST #create' do

    context 'with valid attributes' do

      it 'saves answer in database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
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

      it 'render questions/show view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template 'questions/show'
      end

    end

  end



end
