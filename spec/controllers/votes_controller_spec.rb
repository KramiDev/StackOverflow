require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  describe 'POST #create' do

    sign_in_user
    let!(:question){ create(:question) }

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

  end

end
