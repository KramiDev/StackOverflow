require 'rails_helper'

describe "Profiles API" do
  describe "GET /profiles/" do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let!(:users) { create_list(:user, 2) }

      before { get '/api/v1/profiles', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it 'contain users array' do
        expect(response.body).to be_json_eql(users.to_json).at_path('profiles')
      end

      it 'does no contain current_user' do
        expect(response.body).not_to include_json(me.to_json)
      end

      %w(id email created_at updated_at admin).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(users[0].send(attr.to_sym).to_json).at_path("profiles/0/#{attr}")
        end
      end

      %w(password, encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path("profiles/0/#{attr}")
        end
      end
    end

    # Shared to api_authorization
    def do_request(options = {})
      get api_v1_profiles_path, { format: :json }.merge(options)
    end
  end

  describe "GET /me" do
    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      %w(id email created_at updated_at admin).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password, encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end

    # Shared to api_authorization
    def do_request(options = {})
      get me_api_v1_profiles_path, { format: :json }.merge(options)
    end
  end
end
