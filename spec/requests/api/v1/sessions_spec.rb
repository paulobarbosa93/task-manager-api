require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  before { host! 'api.task-manager.dev' }

  let!(:user) { create(:user) }
  let(:headers) do
    {
      'Accept' => 'application/vnd.taskmanager.v1',
      'Content-Type' => Mime[:json].to_s
    }
  end

  describe 'POST /sessions' do
    before do
      post '/sessions', params: { session: credentials }.to_json, headers: headers
    end

    context 'when valid credentials' do
      let(:credentials) { { email: user.email, password: '123123123' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json data for the user with auth token' do
        user.reload
        expect(json_body[:auth_token]).to eq(user.auth_token)
      end
    end

    context 'when invalid credentials' do
      let(:credentials) { { email: user.email, password: '@@@93939' } }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns the json data for the errors' do
        expect(json_body).to have_key(:errors)
      end
    end
  end
end
