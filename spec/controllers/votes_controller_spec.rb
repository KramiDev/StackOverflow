require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  describe 'POST #create' do
    sign_in_user

    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }

    context 'User like question' do
      it 'Save like in db' do
        expect { post :create, question_id: question, like: 'up', format: :json }.to change(question.votes, :count).by(1)
      end

      it 'Render json' do
        post :create, question_id: question, like: 'up', format: :json
        expect(response).to be_success
      end
    end

    context 'User try to like question 2 times' do
      it 'Not save like in db' do
        post :create, question_id: question, like: 'up', format: :json
        expect { post :create, question_id: question, like: 'up', format: :json }.to change(question.votes, :count).by(0)
      end
    end

    context 'User dislike question' do
      it 'Save dislike in db' do
        expect { post :create, question_id: question, like: 'down', format: :json }.to change(question.votes, :count).by(1)
      end

      it 'Render json' do
        post :create, question_id: question, like: 'down', format: :json
        expect(response).to be_success
      end
    end

    context 'User try to dislike question 2 times' do
      it 'Not save dislike in db' do
        post :create, question_id: question, like: 'down', format: :json
        expect { post :create, question_id: question, like: 'down', format: :json }.to change(question.votes, :count).by(0)
      end
    end

    context 'User like answer' do
      it 'Save like in db' do
        expect { post :create, answer_id: answer, like: 'up', format: :json }.to change(answer.votes, :count).by(1)
      end

      it 'Render json' do
        post :create, answer_id: answer, like: 'up', format: :json
        expect(response).to be_success
      end
    end

    context 'User try to like answer 2 times' do
      it 'Not save like in db' do
        post :create, answer_id: answer, like: 'up', format: :json
        expect { post :create, answer_id: answer, like: 'up', format: :json }.to change(answer.votes, :count).by(0)
      end
    end

    context 'User dislike answer' do
      it 'Save dislike in db' do
        expect { post :create, answer_id: answer, like: 'up', format: :json }.to change(answer.votes, :count).by(1)
      end

      it 'Render json' do
        post :create, answer_id: answer, like: 'up', format: :json
        expect(response).to be_success
      end
    end

    context 'User try to dislike answer 2 times' do
      it 'Not save dislike in db' do
        post :create, answer_id: answer, like: 'up', format: :json
        expect { post :create, answer_id: answer, like: 'up', format: :json }.to change(answer.votes, :count).by(0)
      end
    end
  end
end
