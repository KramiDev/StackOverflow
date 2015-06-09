require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do

    sign_in_user

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

  describe 'DELETE #destroy' do

    sign_in_user

    context 'User try to delete own answer' do

      before { question }

      let!(:answer) { create(:answer, question: question, user: @user) }

      it 'delete answer from database' do
        expect { delete :destroy, question_id: question, id: answer }.to change(Answer, :count).by(-1)
      end

      it 'redirect back to question view' do
        delete :destroy, question_id: question, id: answer
        expect(response).to redirect_to question
      end

    end

    context 'User try to delete other answer' do

      before { question }
      before { answer }

      it 'delete other answer' do
        expect { delete :destroy, question_id: question, id: answer }.to_not change(Answer, :count)
      end

      it 'redirect back to question view' do
        delete :destroy, question_id: question, id: answer
        expect(response).to redirect_to question
      end

    end

  end

end
