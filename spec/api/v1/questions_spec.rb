require 'rails_helper'

describe 'Questions API' do
  let!(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id) }

  describe 'GET /questions' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let!(:questions) { create_list(:question, 2) }
      before { get api_v1_questions_path, format: :json, access_token: access_token.token }

      it 'return 200 status' do
        expect(response).to be_success
      end

      it 'contains questions list' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question contains #{attr} attribute" do
          expect(response.body).to be_json_eql(questions[0].send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end
    end

    # Shared to api_authorization
    def do_request(options = {})
      get api_v1_questions_path, { format: :json }.merge(options)
    end
  end

  describe 'GET /question/:id' do
    let!(:question) { create(:question) }

    it_behaves_like "API Authenticable"

    context 'authorized' do
      let!(:comments) { create_list(:comment, 2, commentable_id: question.id, commentable_type: 'Question') }
      let!(:attachments) { create_list(:attachment, 2, attachable_id: question.id, attachable_type: 'Question') }

      before { get api_v1_question_path(question), format: :json, access_token: access_token.token }

      it 'return 200 status' do
        expect(response).to be_success
      end

      it 'contains question' do
        expect(response.body).to have_json_size(1)
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("question/#{attr}")
        end
      end

      context 'comments' do
        it 'contains comments in question' do
          expect(response.body).to have_json_size(2).at_path('question/comments')
        end

        %w(id body created_at updated_at).each do |attr|
          it "comment contains #{attr}" do
            expect(response.body).to be_json_eql(comments.last.send(attr.to_sym).to_json).at_path("question/comments/0/#{attr}")
          end
        end
      end

      context 'attachments' do
        it 'contains attachments in question' do
          expect(response.body).to have_json_size(2).at_path('question/attachments')
        end

        it "attachment contains file" do
          expect(response.body).to be_json_eql(attachments.last.file.url.to_json).at_path("question/attachments/0/url")
        end
      end
    end

    # Shared to api_authorization
    def do_request(options = {})
      get api_v1_question_path(question), { format: :json }.merge(options)
    end
  end

  describe 'POST /questions' do
    context 'valid attributes' do

      it 'returns status 201' do
        post api_v1_questions_path, format: :json, access_token: access_token.token, question: attributes_for(:question)
        expect(response).to have_http_status :created
      end

      it 'save in db' do
        expect {post api_v1_questions_path, format: :json, access_token: access_token.token, question: attributes_for(:question)}.to change(Question, :count).by(1)
      end
    end

    context 'invalid attributes' do
      it 'returns status 422' do
        post api_v1_questions_path, format: :json, access_token: access_token.token, question: attributes_for(:invalid_question)
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'not save in db' do
        expect {post api_v1_questions_path, format: :json, access_token: access_token.token, question: attributes_for(:invalid_question)}.to_not change(Question, :count)
      end
    end
  end
end