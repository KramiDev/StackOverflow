require 'rails_helper'

describe 'Answer API' do
  let!(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id) }
  let!(:question) { create(:question) }


  describe 'GET /answers' do
    context 'unauthorized' do
      it "return 401 status if no access token" do
        get '/api/v1/answers', format: :json
        expect(response.status).to eq 401
      end
      it "return 401 status if non valid access token" do
        get '/api/v1/answers', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:answers) { create_list(:answer, 2, question: question) }

      before { get api_v1_answers_path, format: :json, access_token: access_token.token}

      it 'return 200 status' do
        expect(response).to be_success
      end

      it 'contains answers list' do
        expect(response.body).to have_json_size(2).at_path('answers')
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer contains #{attr}" do
          expect(response.body).to be_json_eql(answers[0].send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end
  end

  describe 'GET /answer/:id' do
    let!(:answer) { create(:answer, question: question) }
    let!(:comments) { create_list(:comment, 2, commentable_id: answer.id, commentable_type: 'Answer') }
    let!(:attachments) { create_list(:attachment, 2, attachable_id: answer.id, attachable_type: 'Answer') }

    context 'unauthorized' do
      it "return 401 status if no access token" do
        get api_v1_answer_path(answer), format: :json
        expect(response.status).to eq 401
      end
      it "return 401 status if non valid access token" do
        get api_v1_answer_path(answer), format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      before { get api_v1_answer_path(answer), format: :json, access_token: access_token.token }

      it 'return 200 status' do
        expect(response).to be_success
      end

      it 'contains answer' do
        expect(response.body).to have_json_size(1)
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end

      context 'comments' do
        it 'contains comments in answer' do
          expect(response.body).to have_json_size(2).at_path('answer/comments')
        end

        %w(id body created_at updated_at).each do |attr|
          it "comment contains #{attr}" do
            expect(response.body).to be_json_eql(comments[1].send(attr.to_sym).to_json).at_path("answer/comments/0/#{attr}")
          end
        end
      end

      context 'attachments' do
        it 'contains attachments in answer' do
          expect(response.body).to have_json_size(2).at_path('answer/attachments')
        end

        it "attachment contains file" do
          expect(response.body).to be_json_eql(attachments[1].file.url.to_json).at_path("answer/attachments/0/url")
        end
      end
    end
  end
end