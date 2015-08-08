require 'rails_helper'

describe 'Questions API' do
  describe 'GET /questions' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }

    context 'unauthorized' do
      it "return 401 status if no access token" do
        get '/api/v1/questions', format: :json
        expect(response.status).to eq 401
      end
      it "return 401 status if non valid access token" do
        get '/api/v1/questions', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:questions) { create_list(:question, 2) }
      before { get api_v1_questions_path, format: :json, access_token: access_token.token }

      it 'return 200 status' do
        expect(response).to be_success
      end

      it 'contains questions list' do
        expect(response.body).to be_json_eql(questions.to_json).at_path('questions')
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question contains #{attr} attribute" do
          expect(response.body).to be_json_eql(questions[0].send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end
    end
  end
end