require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'GET #index' do
    before { get :index }

    let(:questions) { create_list(:question, 2) }

    it 'get an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it { should render_template :index }
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'get one question by id' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it { should render_template :show }
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }

    it 'get a new question object' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it { should render_template :new }
  end

  describe 'GET #edit' do
    sign_in_user

    before { get :edit, id: question }

    it 'get a question by id for edit' do
      expect(assigns(:question)).to eq question
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, question: attributes_for(:question), format: :js }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question), format: :js
        expect(response).to render_template 'questions/create'
      end
    end

    context 'without valid attributes' do
      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question), format: :js }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question), format: :js
        expect(response).to render_template 'questions/create'
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'valid attributes' do
      it 'find question by id' do
        patch :update, id: question, question: attributes_for(:question), format: :js
        expect(assigns(:question)).to eq question
      end

      it 'change question attribute' do
        patch :update, id: question, question: { title: 'New Title', body: 'New Body' }, format: :js
        question.reload
        expect(question.title).to eq 'New Title'
        expect(question.body).to eq 'New Body'
      end

      it 'redirect to the updated question' do
        patch :update, id: question, question: attributes_for(:question, user: @user), format: :js
        expect(response).to render_template 'questions/update'
      end
    end

    context 'not valid attibutes' do
      it 'it does not update the question' do
        patch :update, id: question, question: attributes_for(:invalid_question), format: :js
        question.reload
        expect(question.title).to eq question.title
        expect(question.body).to eq question.body
      end

      it 'render edit view' do
        patch :update, id: question, question: attributes_for(:invalid_question, user: @user), format: :js
        expect(response).to render_template 'questions/update'
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    before { question }

    context 'User try to delete own question' do
      let!(:question) { create(:question, user: @user) }

      it 'delete the question' do
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it 'redirect to index' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end

    context 'User try delete other question' do
      it 'delete the other question' do
        expect { delete :destroy, id: question }.to_not change(Question, :count)
      end

      it 'redirect to questions_list' do
        delete :destroy, id: question
        expect(response).to redirect_to root_path
      end
    end
  end
end
