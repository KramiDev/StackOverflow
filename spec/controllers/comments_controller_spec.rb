require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }
  let!(:comment) { create(:comment) }
  describe 'POST #create' do
    sign_in_user

    context 'Question with valid attributes' do
      it 'Save in db' do
        expect { post :create, question_id: question, comment: attributes_for(:comment), format: :js }.to change(Comment, :count).by(1)
      end

      it 'Render js' do
        post :create, question_id: question, comment: attributes_for(:comment), format: :js
        expect(response).to render_template 'comments/create'
      end
    end

    context 'Question without valid attributes' do
      it 'No save in db' do
        expect { post :create, question_id: question, comment: attributes_for(:invalid_comment), format: :js }.to change(Comment, :count).by(0)
      end

      it 'Render js' do
        post :create, question_id: question, comment: attributes_for(:invalid_comment), format: :js
        expect(response).to render_template 'comments/create'
      end
    end

    context 'Answer with valid attributes' do
      it 'Save in db' do
        expect { post :create, question_id: question, answer: answer, comment: attributes_for(:comment), format: :js }.to change(Comment, :count).by(1)
      end

      it 'Render js' do
        post :create, question_id: question, answer: answer, comment: attributes_for(:comment), format: :js
        expect(response).to render_template 'comments/create'
      end
    end

    context 'Answer without valid attributes' do
      it 'No save in db' do
        expect { post :create, question_id: question, answer: answer, comment: attributes_for(:invalid_comment), format: :js }.to change(Comment, :count).by(0)
      end

      it 'Render js' do
        post :create, question_id: question, answer: answer, comment: attributes_for(:invalid_comment), format: :js
        expect(response).to render_template 'comments/create'
      end
    end
  end
end
