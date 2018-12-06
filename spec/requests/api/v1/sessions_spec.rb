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

  describe "POST /sessions" do
    before do
      post '/sessions', params: { session: credentials.to_json }, headers: headers
    end
  end
end
