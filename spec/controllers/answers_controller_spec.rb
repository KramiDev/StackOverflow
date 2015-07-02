require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }
  let!(:answer1) { create(:answer, question: question, best: true) }

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves answer in database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template 'answers/create'
      end
    end

    context 'without valid attributes' do
      it 'does not save answer in database' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(Answer, :count)
      end

      it 'render questions/show view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template 'answers/create'
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    before { answer.update!(user: @user) }

    context 'with valid attributes' do
      it 'update answer in database' do
        patch :update, question_id: question, id: answer, answer: { body: 'TestTest' }, format: :js
        answer.reload
        expect(answer.body).to eq 'TestTest'
      end

      it 'render template answers/update' do
        patch :update, question_id: question, id: answer, answer: { body: 'TestTest' }, format: :js
        expect(response).to render_template 'answers/update'
      end
    end

    context 'without valid attributes' do
      it 'update answer in database' do
        patch :update, question_id: question, id: answer, answer: attributes_for(:invalid_answer), format: :js
        answer.reload
        expect(answer.body).to eq answer.body
      end

      it 'render template answers/update' do
        patch :update, question_id: question, id: answer, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template 'answers/update'
      end
    end
  end

  describe 'POST #best' do
    sign_in_user

    context 'Author check best answer' do
      before { question.update!(user: @user) }

      it 'render template answers/best' do
        post :best, question_id: question, id: answer, answer: { best: true }, format: :js
        expect(response).to render_template 'answers/best'
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'User try to delete own answer' do
      before { answer.update!(user: @user) }

      it 'delete answer from database' do
        expect { delete :destroy, question_id: question, id: answer, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'redirect back to question view' do
        delete :destroy, question_id: question, id: answer, format: :js
        expect(response).to render_template 'answers/destroy'
      end
    end

    context 'User try to delete other answer' do
      before { question }
      before { answer }

      it 'delete other answer' do
        expect { delete :destroy, question_id: question, id: answer, format: :js }.to_not change(Answer, :count)
      end

      it 'redirect back to question view' do
        delete :destroy, question_id: question, id: answer, format: :js
        expect(response).to render_template 'answers/destroy'
      end
    end
  end
end
