require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:question) { create(:question) }
  let!(:comment) { create(:comment) }
  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'Save in db' do
        expect { post :create, question_id: question, comment: attributes_for(:comment), format: :js }.to change(Comment, :count).by(1)
      end

      it 'Render js' do
        post :create, question_id: question, comment: attributes_for(:comment), format: :js
        expect(response).to render_template 'comments/create'
      end
    end

    context 'without valid attributes' do
      it 'No save in db' do
        expect { post :create, question_id: question, comment: attributes_for(:invalid_comment), format: :js }.to change(Comment, :count).by(0)
      end

      it 'Render js' do
        post :create, question_id: question, comment: attributes_for(:invalid_comment), format: :js
        expect(response).to render_template 'comments/create'
      end
    end
  end
end
